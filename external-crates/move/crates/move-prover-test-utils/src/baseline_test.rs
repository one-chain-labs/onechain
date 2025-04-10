// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

//! A module supporting baseline (golden) tests.

use anyhow::anyhow;
use move_command_line_common::testing::read_env_update_baseline;
use prettydiff::{basic::DiffOp, diff_lines};
use regex::Regex;
use std::{fs, path::Path};

/// Verifies or updates baseline file for the given generated text.
pub fn verify_or_update_baseline(baseline_file_name: &Path, text: &str) -> anyhow::Result<()> {
    let update_baseline = read_env_update_baseline();

    if update_baseline {
        if !text.is_empty() {
            // Update the baseline file.
            if let Some(parent) = baseline_file_name.parent() {
                fs::create_dir_all(parent)?;
            }
            let clean_text = clean_for_baseline(text);
            fs::write(baseline_file_name, clean_text)?;
        } else if baseline_file_name.exists() {
            fs::remove_file(baseline_file_name)?;
        }

        Ok(())
    } else {
        // Read the baseline and diff it.
        let contents = if baseline_file_name.exists() { fs::read_to_string(baseline_file_name)? } else { String::new() };
        diff(clean_for_baseline(text).as_ref(), &contents)
    }
}

/// Clean a content to be usable as a baseline file. Currently, we ensure there are no
/// trailing whitespaces and no empty last line, because this is required by git-checks.sh.
/// We also try to detect and remove unstable file names.
fn clean_for_baseline(content: &str) -> String {
    // Regexp for matching unstable filenames in output. This is heuristic and may need refinement
    // on a case-by-case basis.
    let rex = Regex::new(r"(/var|/tmp)(/[^/]*)*/(?P<basename>[^.]*\.)").expect("regexp ok");
    let mut res = String::new();
    for line in content.lines() {
        let line = line.trim_end();
        let line = rex.replace_all(line, "$basename");
        res.push_str(line.to_string().as_str());
        res.push('\n');
    }
    res = res.trim_end().to_string(); // removes empty lines at end
    res.push('\n'); // adds back a single newline
    res
}

/// Diffs old and new content.
fn diff(old_content: &str, new_content: &str) -> anyhow::Result<()> {
    if old_content.trim() == new_content.trim() {
        return Ok(());
    }

    let print_lines = |result: &mut Vec<String>, lines: &[&str], prefix: &str| {
        for line in lines {
            result.push(format!("{}{}", prefix, line));
        }
    };

    let print_context = |result: &mut Vec<String>, lines: &[&str]| {
        if lines.len() <= 3 {
            print_lines(result, lines, "= ");
        } else {
            print_lines(result, &lines[..1], "= ");
            result.push(format!("= ... ({} lines)", lines.len() - 2));
            print_lines(result, &lines[lines.len() - 1..], "= ");
        }
    };

    let diff = diff_lines(new_content, old_content);
    let mut result = vec!["
New output differs from baseline!
Call this test with env variable UPBL=1 to regenerate or remove old baseline files.
Then use your favorite changelist diff tool to verify you are good with the changes.

Or check the rudimentary diff below:
"
    .to_string()];
    for d in diff.diff() {
        match d {
            DiffOp::Equal(lines) => print_context(&mut result, lines),
            DiffOp::Insert(lines) => print_lines(&mut result, lines, "+ "),
            DiffOp::Remove(lines) => print_lines(&mut result, lines, "- "),
            DiffOp::Replace(old, new) => {
                print_lines(&mut result, old, "- ");
                print_lines(&mut result, new, "+ ");
            }
        }
    }
    Err(anyhow!(result.join("\n")))
}
