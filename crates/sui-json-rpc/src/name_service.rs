// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

use move_core_types::{ident_str, identifier::IdentStr, language_storage::StructTag};
use serde::{Deserialize, Serialize};
use std::{fmt, marker::PhantomData, str::FromStr};
use sui_types::{
    base_types::{ObjectID, SuiAddress},
    collection_types::VecMap,
    dynamic_field::Field,
    id::{ID, UID},
    object::{MoveObject, Object},
    TypeTag,
};

const NAME_SERVICE_DOMAIN_MODULE: &IdentStr = ident_str!("domain");
const NAME_SERVICE_DOMAIN_STRUCT: &IdentStr = ident_str!("Domain");
const LEAF_EXPIRATION_TIMESTAMP: u64 = 0;
const DEFAULT_TLD: &str = "oct";
const ACCEPTED_SEPARATORS: [char; 2] = ['.', '*'];
const SUI_NEW_FORMAT_SEPARATOR: char = '@';

/// Two different view options for a domain.
/// `At` -> `test@example` | `Dot` -> `test.example.sui`
#[derive(Clone, Eq, PartialEq, Debug)]
pub enum DomainFormat {
    At,
    Dot,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Registry {
    /// The `registry` table maps `Domain` to `NameRecord`.
    /// Added / replaced in the `add_record` function.
    registry: Table<Domain, NameRecord>,
    /// The `reverse_registry` table maps `address` to `domain_name`.
    /// Updated in the `set_reverse_lookup` function.
    reverse_registry: Table<SuiAddress, Domain>,
}

/// Rust version of the Move sui::table::Table type.
#[derive(Debug, Serialize, Deserialize, Clone, Eq, PartialEq)]
pub struct Table<K, V> {
    pub id: ObjectID,
    pub size: u64,

    #[serde(skip)]
    _key: PhantomData<K>,
    #[serde(skip)]
    _value: PhantomData<V>,
}

#[derive(Debug, Serialize, Deserialize, Clone, Eq, Hash, PartialEq)]
pub struct Domain {
    labels: Vec<String>,
}

impl Domain {
    pub fn type_(package_address: SuiAddress) -> StructTag {
        StructTag {
            address: package_address.into(),
            module: NAME_SERVICE_DOMAIN_MODULE.to_owned(),
            name: NAME_SERVICE_DOMAIN_STRUCT.to_owned(),
            type_params: vec![],
        }
    }

    /// Derive the parent domain for a given domain
    /// E.g. `test.example.sui` -> `example.sui`
    ///
    /// SAFETY: This is a safe operation because we only allow a
    /// domain's label vector size to be >= 2 (see `Domain::from_str`)
    pub fn parent(&self) -> Domain {
        Domain { labels: self.labels[0..(self.labels.len() - 1)].to_vec() }
    }

    pub fn is_subdomain(&self) -> bool {
        self.depth() >= 3
    }

    /// Returns the depth for a name.
    /// Depth is defined by the amount of labels in a domain, including TLD.
    /// E.g. `test.example.sui` -> `3`
    ///
    /// SAFETY: We can safely cast to a u8 as the max depth is 235.
    pub fn depth(&self) -> u8 {
        self.labels.len() as u8
    }

    /// Formats a domain into a string based on the available output formats.
    /// The default separator is `.`
    pub fn format(&self, format: DomainFormat) -> String {
        let mut labels = self.labels.clone();
        let sep = &ACCEPTED_SEPARATORS[0].to_string();
        labels.reverse();

        if format == DomainFormat::Dot {
            return labels.join(sep);
        };

        // SAFETY: This is a safe operation because we only allow a
        // domain's label vector size to be >= 2 (see `Domain::from_str`)
        let _tld = labels.pop();
        let sld = labels.pop().unwrap();

        format!("{}{}{}", labels.join(sep), SUI_NEW_FORMAT_SEPARATOR, sld)
    }
}

#[derive(Clone, Debug, Serialize, Deserialize, Eq, PartialEq)]
#[serde(rename_all = "kebab-case")]
pub struct NameServiceConfig {
    pub package_address: SuiAddress,
    pub registry_id: ObjectID,
    pub reverse_registry_id: ObjectID,
}

impl NameServiceConfig {
    pub fn new(package_address: SuiAddress, registry_id: ObjectID, reverse_registry_id: ObjectID) -> Self {
        Self { package_address, registry_id, reverse_registry_id }
    }

    pub fn record_field_id(&self, domain: &Domain) -> ObjectID {
        let domain_type_tag = Domain::type_(self.package_address);
        let domain_bytes = bcs::to_bytes(domain).unwrap();

        sui_types::dynamic_field::derive_dynamic_field_id(
            self.registry_id,
            &TypeTag::Struct(Box::new(domain_type_tag)),
            &domain_bytes,
        )
        .unwrap()
    }

    pub fn reverse_record_field_id(&self, address: &[u8]) -> ObjectID {
        sui_types::dynamic_field::derive_dynamic_field_id(self.reverse_registry_id, &TypeTag::Address, address).unwrap()
    }

    // Create a config based on the package and object ids published on mainnet
    pub fn mainnet() -> Self {
        const MAINNET_NS_PACKAGE_ADDRESS: &str = "0xb518b15510de80320a046288ca391a2a06b8aa4ca979287549edc123dbe8313f";
        const MAINNET_NS_REGISTRY_ID: &str = "0x7bd439c354340ced161f29bbd9ee8c4799402fb83ec43eec0277a356e68878cf";
        const MAINNET_NS_REVERSE_REGISTRY_ID: &str =
            "0x3040c34cff1bc755e9a58a0b14973648757cbed4826ff2cd8a20df292f3547b7";

        let package_address = SuiAddress::from_str(MAINNET_NS_PACKAGE_ADDRESS).unwrap();
        let registry_id = ObjectID::from_str(MAINNET_NS_REGISTRY_ID).unwrap();
        let reverse_registry_id = ObjectID::from_str(MAINNET_NS_REVERSE_REGISTRY_ID).unwrap();

        Self::new(package_address, registry_id, reverse_registry_id)
    }

    // Create a config based on the package and object ids published on testnet
    pub fn testnet() -> Self {
        const TESTNET_NS_PACKAGE_ADDRESS: &str = "0xc0e4184d4e6026206ae6b1fb454d17478ffb5174380707bb37add35610b79b51";
        const TESTNET_NS_REGISTRY_ID: &str = "0xb01097dfebb8fe21fe91a4502051e94920cc78c5382708271732b430e1af281f";
        const TESTNET_NS_REVERSE_REGISTRY_ID: &str =
            "0x6f35cfef2e07be3323901211a4e5cdd9ab8fef5274489ca0481ab38a754e0eb4";

        let package_address = SuiAddress::from_str(TESTNET_NS_PACKAGE_ADDRESS).unwrap();
        let registry_id = ObjectID::from_str(TESTNET_NS_REGISTRY_ID).unwrap();
        let reverse_registry_id = ObjectID::from_str(TESTNET_NS_REVERSE_REGISTRY_ID).unwrap();

        Self::new(package_address, registry_id, reverse_registry_id)
    }
}

impl Default for NameServiceConfig {
    fn default() -> Self {
        Self::mainnet()
    }
}

impl FromStr for Domain {
    type Err = NameServiceError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        /// The maximum length of a full domain
        const MAX_DOMAIN_LENGTH: usize = 200;

        if s.len() > MAX_DOMAIN_LENGTH {
            return Err(NameServiceError::ExceedsMaxLength(s.len(), MAX_DOMAIN_LENGTH));
        }
        let separator = separator(s)?;

        let formatted_string = convert_from_new_format(s, &separator)?;

        let labels =
            formatted_string.split(separator).rev().map(validate_label).collect::<Result<Vec<_>, Self::Err>>()?;

        // A valid domain in our system has at least a TLD and an SLD (len == 2).
        if labels.len() < 2 {
            return Err(NameServiceError::LabelsEmpty);
        }

        let labels = labels.into_iter().map(ToOwned::to_owned).collect();
        Ok(Domain { labels })
    }
}

/// Parses a separator from the domain string input.
/// E.g.  `example.sui` -> `.` | example*sui -> `@` | `example*sui` -> `*`
fn separator(s: &str) -> Result<char, NameServiceError> {
    let mut domain_separator: Option<char> = None;

    for separator in ACCEPTED_SEPARATORS.iter() {
        if s.contains(*separator) {
            if domain_separator.is_some() {
                return Err(NameServiceError::InvalidSeparator);
            }

            domain_separator = Some(*separator);
        }
    }

    match domain_separator {
        Some(separator) => Ok(separator),
        None => Ok(ACCEPTED_SEPARATORS[0]),
    }
}

/// Converts @label ending to label{separator}sui ending.
///
/// E.g. `@example` -> `example.sui` | `test@example` -> `test.example.sui`
fn convert_from_new_format(s: &str, separator: &char) -> Result<String, NameServiceError> {
    let mut splits = s.split(SUI_NEW_FORMAT_SEPARATOR);

    let Some(before) = splits.next() else {
        return Err(NameServiceError::InvalidSeparator);
    };

    let Some(after) = splits.next() else {
        return Ok(before.to_string());
    };

    if splits.next().is_some() || after.contains(*separator) || after.is_empty() {
        return Err(NameServiceError::InvalidSeparator);
    }

    let mut parts = vec![];

    if !before.is_empty() {
        parts.push(before);
    }

    parts.push(after);
    parts.push(DEFAULT_TLD);

    Ok(parts.join(&separator.to_string()))
}

pub fn validate_label(label: &str) -> Result<&str, NameServiceError> {
    const MIN_LABEL_LENGTH: usize = 1;
    const MAX_LABEL_LENGTH: usize = 63;
    let bytes = label.as_bytes();
    let len = bytes.len();

    if !(MIN_LABEL_LENGTH..=MAX_LABEL_LENGTH).contains(&len) {
        return Err(NameServiceError::InvalidLength(len, MIN_LABEL_LENGTH, MAX_LABEL_LENGTH));
    }

    for (i, character) in bytes.iter().enumerate() {
        let is_valid_character = match character {
            b'a'..=b'z' => true,
            b'0'..=b'9' => true,
            b'-' if i != 0 && i != len - 1 => true,
            _ => false,
        };

        if !is_valid_character {
            match character {
                b'-' => return Err(NameServiceError::InvalidHyphens),
                _ => return Err(NameServiceError::InvalidUnderscore),
            }
        };
    }
    Ok(label)
}

impl fmt::Display for Domain {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        // We use to_string() to check on-chain state and parse on-chain data
        // so we should always default to DOT format.
        let output = self.format(DomainFormat::Dot);
        f.write_str(&output)?;

        Ok(())
    }
}

/// A single record in the registry.
#[derive(Debug, Serialize, Deserialize, Clone, Eq, PartialEq)]
pub struct NameRecord {
    /// The ID of the `RegistrationNFT` assigned to this record.
    ///
    /// The owner of the corrisponding `RegistrationNFT` has the rights to
    /// be able to change and adjust the `target_address` of this domain.
    ///
    /// It is possible that the ID changes if the record expires and is
    /// purchased by someone else.
    pub nft_id: ID,
    /// Timestamp in milliseconds when the record expires.
    pub expiration_timestamp_ms: u64,
    /// The target address that this domain points to
    pub target_address: Option<SuiAddress>,
    /// Additional data which may be stored in a record
    pub data: VecMap<String, String>,
}

impl NameRecord {
    /// Leaf records expire when their parent expires.
    /// The `expiration_timestamp_ms` is set to `0` (on-chain) to indicate this.
    pub fn is_leaf_record(&self) -> bool {
        self.expiration_timestamp_ms == LEAF_EXPIRATION_TIMESTAMP
    }

    /// Validate that a `NameRecord` is a valid parent of a child `NameRecord`.
    ///
    /// WARNING: This only applies for `leaf` records
    pub fn is_valid_leaf_parent(&self, child: &NameRecord) -> bool {
        self.nft_id == child.nft_id
    }

    /// Checks if a `node` name record has expired.
    /// Expects the latest checkpoint's timestamp.
    pub fn is_node_expired(&self, checkpoint_timestamp_ms: u64) -> bool {
        self.expiration_timestamp_ms < checkpoint_timestamp_ms
    }
}

impl TryFrom<Object> for NameRecord {
    type Error = NameServiceError;

    fn try_from(object: Object) -> Result<Self, NameServiceError> {
        object
            .to_rust::<Field<Domain, Self>>()
            .map(|record| record.value)
            .ok_or_else(|| NameServiceError::MalformedObject(object.id()))
    }
}

impl TryFrom<MoveObject> for NameRecord {
    type Error = NameServiceError;

    fn try_from(object: MoveObject) -> Result<Self, NameServiceError> {
        object
            .to_rust::<Field<Domain, Self>>()
            .map(|record| record.value)
            .ok_or_else(|| NameServiceError::MalformedObject(object.id()))
    }
}

#[derive(thiserror::Error, Debug, Serialize, Deserialize, Clone, Eq, PartialEq)]
pub enum NameServiceError {
    #[error("Name Service: String length: {0} exceeds maximum allowed length: {1}")]
    ExceedsMaxLength(usize, usize),
    #[error("Name Service: String length: {0} outside of valid range: [{1}, {2}]")]
    InvalidLength(usize, usize, usize),
    #[error("Name Service: Hyphens are not allowed as the first or last character")]
    InvalidHyphens,
    #[error("Name Service: Only lowercase letters, numbers, and hyphens are allowed")]
    InvalidUnderscore,
    #[error("Name Service: Domain must contain at least one label")]
    LabelsEmpty,
    #[error("Name Service: Domain must include only one separator")]
    InvalidSeparator,

    #[error("Name Service: Name has expired.")]
    NameExpired,
    #[error("Name Service: Malformed object for {0}")]
    MalformedObject(ObjectID),
}

/// A SuinsRegistration object to manage an SLD
#[derive(Debug, Serialize, Deserialize, Clone, Eq, PartialEq)]
pub struct SuinsRegistration {
    pub id: UID,
    pub domain: Domain,
    pub domain_name: String,
    pub expiration_timestamp_ms: u64,
    pub image_url: String,
}

/// A SubDomainRegistration object to manage a subdomain.
#[derive(Debug, Serialize, Deserialize, Clone, Eq, PartialEq)]
pub struct SubDomainRegistration {
    pub id: UID,
    pub nft: SuinsRegistration,
}
