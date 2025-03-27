// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

use expect_test::expect;
use std::{
    fs::{self, File},
    io::{self, Read, Write},
    path::PathBuf,
};
use tempfile::TempDir;

use move_compiler::editions::{Edition, Flavor};
use move_package::{
    lock_file::{
        schema::{update_managed_address, ManagedAddressUpdate, ManagedPackage, ToolchainVersion},
        LockFile,
    },
    resolution::dependency_graph::DependencyGraph,
    BuildConfig,
};
use move_symbol_pool::Symbol;

#[test]
fn commit() {
    let pkg = create_test_package().unwrap();
    let lock_path = pkg.path().join("Move.lock");

    {
        let mut lock = LockFile::new(
            pkg.path().to_path_buf(),
            /* manifest_digest */ "42".to_string(),
            /* deps_digest */ "7".to_string(),
        )
        .unwrap();
        writeln!(lock, "# Write and commit").unwrap();
        lock.commit(&lock_path).unwrap();
    }

    assert!(lock_path.is_file());

    let lock_contents = {
        let mut lock_file = File::open(lock_path).unwrap();
        let mut buf = String::new();
        lock_file.read_to_string(&mut buf).unwrap();
        buf
    };

    // Check that the content written into the `LockFile` instance above can be found at the path
    // that that lock file was committed to (indicating that the commit actually happened).
    assert!(
        lock_contents.ends_with("# Write and commit\n"),
        "Lock file doesn't have expected content:\n{}",
        lock_contents,
    );
}

#[test]
fn discard() {
    let pkg = create_test_package().unwrap();

    {
        let mut lock = LockFile::new(
            pkg.path().to_path_buf(),
            /* manifest_digest */ "42".to_string(),
            /* deps_digest */ "7".to_string(),
        )
        .unwrap();
        writeln!(lock, "# Write but don't commit").unwrap();
    }

    assert!(!pkg.path().join("Move.lock").is_file());
}

#[test]
fn update_lock_file_dependency_graph() {
    let pkg = create_test_package().unwrap();

    // Create a lock file that will be updated with dependency graph contents.
    // The [move.toolchain-version] contents should be retained.
    let lock_path = pkg.path().join("Move.lock");
    let lock_contents = r#"# @generated by Move, please check-in and do not edit manually.

[move]
version = 1
manifest_digest = "0"
deps_digest = "0"

[move.toolchain-version]
compiler-version = "0.0.0"
edition = "legacy"
flavor = "sui"
"#;
    fs::write(lock_path.clone(), lock_contents).unwrap();

    // For convenience, create a graph by deserializing from lock contents
    let lock_path_with_graph = pkg.path().join("Move.lock.graph");
    let lock_graph_contents = r#"
        # @generated by Move, please check-in and do not edit manually.

        [move]
        version = 3
        manifest_digest = "0"
        deps_digest = "0"

        dependencies = [
          { id = "Dep", name = "Dep" }
        ]

        [[move.package]]
        id = "Dep"
        source = { local = "some/path" }
	"#;
    fs::write(lock_path_with_graph.clone(), lock_graph_contents).unwrap();

    let graph = DependencyGraph::read_from_lock(
        pkg.path().to_path_buf(),
        Symbol::from("Root"),
        Symbol::from("Root"),
        &mut File::open(&lock_path_with_graph).expect("Open lock file"),
        None,
    )
    .expect("Read DependencyGraph");

    let lock = graph.write_to_lock(pkg.path().to_path_buf(), Some(lock_path.clone())).expect("Write DependencyGraph");
    lock.commit(&lock_path).expect("Commit lock file");

    let mut lock = File::open(&lock_path).expect("Reading lock file");
    let contents = {
        let mut buf = String::new();
        let _ = lock.read_to_string(&mut buf);
        buf
    };

    let expected = expect![[r#"
        # @generated by Move, please check-in and do not edit manually.

        [move]
        version = 3
        manifest_digest = "0"
        deps_digest = "0"
        dependencies = [
          { id = "Dep", name = "Dep" },
        ]

        [[move.package]]
        id = "Dep"
        source = { local = "some/path" }

        [move.toolchain-version]
        compiler-version = "0.0.0"
        edition = "legacy"
        flavor = "sui"
    "#]];
    expected.assert_eq(&contents);
}

#[test]
fn update_lock_file_toolchain_version() {
    let pkg = create_test_package().unwrap();
    let move_manifest = pkg.path().join("Move.toml");
    // The 2024.beta in the manifest should override defaults.
    fs::write(
        move_manifest,
        r#"
          [package]
          name = "test"
          edition = "2024.beta"
        "#,
    )
    .unwrap();

    let lock_path = pkg.path().join("Move.lock");
    let lock = LockFile::new(
        pkg.path().to_path_buf(),
        /* manifest_digest */ "42".to_string(),
        /* deps_digest */ "7".to_string(),
    )
    .unwrap();
    lock.commit(&lock_path).unwrap();

    let build_config = BuildConfig {
        default_flavor: Some(Flavor::Sui),
        default_edition: Some(Edition::E2024_ALPHA),
        lock_file: Some(lock_path.clone()),
        ..Default::default()
    };
    let _ = build_config.update_lock_file_toolchain_version(pkg.path(), "0.0.1".into());

    let mut lock_file = File::open(lock_path).unwrap();
    let toolchain_version = ToolchainVersion::read(&mut lock_file).expect("Invalid toolchain version");
    let toml = toml::ser::to_string(&toolchain_version).expect("Unable to serialize toolchain version");

    let expected = expect![[r#"
        compiler-version = "0.0.1"
        edition = "2024.beta"
        flavor = "sui"
    "#]];
    expected.assert_eq(&toml);
}

#[test]
fn test_update_managed_address() {
    let pkg = create_test_package().unwrap();
    let lock_path = pkg.path().join("Move.lock");

    // Initialize lock file.
    let lock = LockFile::new(
        pkg.path().to_path_buf(),
        /* manifest_digest */ "42".to_string(),
        /* deps_digest */ "7".to_string(),
    )
    .unwrap();
    lock.commit(&lock_path).unwrap();

    // Update managed address in lock file.
    let pb = PathBuf::from(pkg.path());
    let mut lock = LockFile::from(pb, &lock_path).unwrap();
    update_managed_address(&mut lock, "default", ManagedAddressUpdate::Published {
        original_id: "0x123".into(),
        chain_id: "35834a8a".into(),
    })
    .unwrap();

    update_managed_address(&mut lock, "default", ManagedAddressUpdate::Upgraded {
        latest_id: "0x456".into(),
        version: 2,
    })
    .unwrap();
    lock.commit(&lock_path).unwrap();

    // Read lock file and check contents.
    let mut lock_file = File::open(lock_path).unwrap();
    let envs: Vec<_> = ManagedPackage::read(&mut lock_file).unwrap().into_iter().collect();

    let expected = expect![[r#"
        [
            (
                "default",
                ManagedPackage {
                    chain_id: "35834a8a",
                    original_published_id: "0x123",
                    latest_published_id: "0x456",
                    version: "2",
                },
            ),
        ]
    "#]];
    expected.assert_debug_eq(&envs);
}

/// Create a simple Move package with no sources (just a manifest and an output directory) in a
/// temporary directory, and return it.
fn create_test_package() -> io::Result<TempDir> {
    let dir = tempfile::tempdir()?;

    let toml_path: PathBuf = [".", "tests", "test_sources", "basic_no_deps", "Move.toml"].into_iter().collect();

    fs::copy(toml_path, dir.path().join("Move.toml"))?;
    Ok(dir)
}
