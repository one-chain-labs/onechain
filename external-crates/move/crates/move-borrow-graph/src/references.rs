// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

use crate::{
    paths::{self, Path},
    shared::*,
};
use std::{
    cmp::Ordering,
    collections::{BTreeMap, BTreeSet},
    fmt,
    fmt::Debug,
};

//**************************************************************************************************
// Definitions
//**************************************************************************************************

/// Unique identifier for the reference
#[derive(Copy, Clone, Debug, Eq, PartialEq, Ord, PartialOrd)]
pub struct RefID(pub(crate) usize);

impl RefID {
    /// Creates a new reference id from the given number
    pub const fn new(x: usize) -> Self {
        RefID(x)
    }

    /// Returns the number representing this reference id.
    pub fn number(&self) -> usize {
        self.0
    }
}

/// An edge in the borrow graph
#[derive(Clone)]
pub(crate) struct BorrowEdge<Loc: Copy, Lbl: Clone + Ord> {
    /// true if it is an exact (strong) edge,
    /// false if it is a prefix (weak) edge
    pub(crate) strong: bool,
    /// The path (either exact/prefix strong/weak) for the borrow relationship of this edge
    pub(crate) path: Path<Lbl>,
    /// Location information for the edge
    pub(crate) loc: Loc,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct BorrowEdgeSet<Loc: Copy, Lbl: Clone + Ord> {
    edges: BTreeSet<BorrowEdge<Loc, Lbl>>,
    // true if the set has hit the `MAX_EDGE_SET_SIZE`
    // See `MAX_EDGE_SET_SIZE` for more details
    overflown: bool,
}

/// Represents outgoing edges in the borrow graph
#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct BorrowEdges<Loc: Copy, Lbl: Clone + Ord>(pub(crate) BTreeMap<RefID, BorrowEdgeSet<Loc, Lbl>>);

/// Represents the borrow relationships and information for a node in the borrow graph, i.e
/// for a single reference
#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Ref<Loc: Copy, Lbl: Clone + Ord> {
    /// Parent to child
    /// 'self' is borrowed by _
    pub(crate) borrowed_by: BorrowEdges<Loc, Lbl>,
    /// Child to parent
    /// 'self' borrows from _
    /// Needed for efficient querying, but should be in one-to-one corespondence with borrowed by
    /// i.e. x is borrowed by y IFF y borrows from x
    pub(crate) borrows_from: BTreeSet<RefID>,
    /// true if mutable, false otherwise
    pub(crate) mutable: bool,
}

//**************************************************************************************************
// Impls
//**************************************************************************************************

impl<Loc: Copy, Lbl: Clone + Ord> BorrowEdge<Loc, Lbl> {
    pub(crate) fn leq(&self, other: &Self) -> bool {
        self == other || (!self.strong && paths::leq(&self.path, &other.path))
    }
}

// The borrow set has a maximum size.
// Beyond that size, the borrow-set becomes lossy and is considered to borrow any possible edge
// (or extension) from the source reference
pub const MAX_EDGE_SET_SIZE: usize = 10;
impl<Loc: Copy, Lbl: Clone + Ord> BorrowEdgeSet<Loc, Lbl> {
    pub(crate) fn new() -> Self {
        Self { edges: BTreeSet::new(), overflown: false }
    }

    pub(crate) fn insert(&mut self, edge: BorrowEdge<Loc, Lbl>) {
        debug_assert!(self.edges.len() <= MAX_EDGE_SET_SIZE);
        if self.overflown {
            debug_assert!(!self.is_empty());
            return;
        }
        if self.edges.len() + 1 > MAX_EDGE_SET_SIZE {
            let loc = edge.loc;
            self.edges = BTreeSet::from([BorrowEdge { strong: false, path: vec![], loc }]);
            self.overflown = true
        } else {
            self.edges.insert(edge);
        }
    }

    pub(crate) fn remove(&mut self, edge: &BorrowEdge<Loc, Lbl>) -> bool {
        let was_removed = self.edges.remove(edge);
        debug_assert!(was_removed);
        was_removed
    }

    pub(crate) fn len(&self) -> usize {
        self.edges.len()
    }

    pub(crate) fn is_empty(&self) -> bool {
        self.edges.is_empty()
    }

    pub(crate) fn iter(&self) -> std::collections::btree_set::Iter<BorrowEdge<Loc, Lbl>> {
        debug_assert!(self.overflown || !self.is_empty());
        self.edges.iter()
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> BorrowEdges<Loc, Lbl> {
    pub(crate) fn new() -> Self {
        Self(BTreeMap::new())
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> Ref<Loc, Lbl> {
    pub(crate) fn new(mutable: bool) -> Self {
        let borrowed_by = BorrowEdges::new();
        let borrows_from = BTreeSet::new();
        Self { borrowed_by, borrows_from, mutable }
    }
}

//**********************************************************************************************
// Remap
//**********************************************************************************************

impl<Loc: Copy, Lbl: Clone + Ord> BorrowEdges<Loc, Lbl> {
    /// Utility for remapping the reference ids according the `id_map` provided
    /// If it is not in the map, the id remains the same
    pub(crate) fn remap_refs(&mut self, id_map: &BTreeMap<RefID, RefID>) {
        let _before = self.0.len();
        self.0 = std::mem::take(&mut self.0)
            .into_iter()
            .map(|(id, edges)| (id_map.get(&id).copied().unwrap_or(id), edges))
            .collect();
        let _after = self.0.len();
        debug_assert!(_before == _after)
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> Ref<Loc, Lbl> {
    /// Utility for remapping the reference ids according the `id_map` provided
    /// If it is not in the map, the id remains the same
    pub(crate) fn remap_refs(&mut self, id_map: &BTreeMap<RefID, RefID>) {
        self.borrowed_by.remap_refs(id_map);
        remap_set(&mut self.borrows_from, id_map)
    }
}

//**********************************************************************************************
// Traits
//**********************************************************************************************

/// Dummy struct used to implement traits for BorrowEdge that skips over the loc field
#[derive(Clone, Debug, Eq, PartialEq, Ord, PartialOrd)]
struct BorrowEdgeNoLoc<'a, Lbl: Clone> {
    strong: bool,
    path: &'a Path<Lbl>,
}

impl<'a, Lbl: Clone + Ord> BorrowEdgeNoLoc<'a, Lbl> {
    fn new<Loc: Copy>(e: &'a BorrowEdge<Loc, Lbl>) -> Self {
        BorrowEdgeNoLoc { strong: e.strong, path: &e.path }
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> PartialEq for BorrowEdge<Loc, Lbl> {
    fn eq(&self, other: &BorrowEdge<Loc, Lbl>) -> bool {
        BorrowEdgeNoLoc::new(self) == BorrowEdgeNoLoc::new(other)
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> Eq for BorrowEdge<Loc, Lbl> {}

#[allow(clippy::non_canonical_partial_ord_impl)]
impl<Loc: Copy, Lbl: Clone + Ord> PartialOrd for BorrowEdge<Loc, Lbl> {
    fn partial_cmp(&self, other: &BorrowEdge<Loc, Lbl>) -> Option<Ordering> {
        BorrowEdgeNoLoc::new(self).partial_cmp(&BorrowEdgeNoLoc::new(other))
    }
}

impl<Loc: Copy, Lbl: Clone + Ord> Ord for BorrowEdge<Loc, Lbl> {
    fn cmp(&self, other: &BorrowEdge<Loc, Lbl>) -> Ordering {
        BorrowEdgeNoLoc::new(self).cmp(&BorrowEdgeNoLoc::new(other))
    }
}

impl<Loc: Copy, Lbl: Clone + Ord + Debug> Debug for BorrowEdge<Loc, Lbl> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        BorrowEdgeNoLoc::new(self).fmt(f)
    }
}

//**********************************************************************************************
// Iteration
//**********************************************************************************************

impl<Loc: Copy, Lbl: Clone + Ord> IntoIterator for BorrowEdgeSet<Loc, Lbl> {
    type IntoIter = std::collections::btree_set::IntoIter<BorrowEdge<Loc, Lbl>>;
    type Item = BorrowEdge<Loc, Lbl>;

    fn into_iter(self) -> Self::IntoIter {
        debug_assert!(self.overflown || !self.is_empty());
        self.edges.into_iter()
    }
}

impl<'a, Loc: Copy, Lbl: Clone + Ord> IntoIterator for &'a BorrowEdgeSet<Loc, Lbl> {
    type IntoIter = std::collections::btree_set::Iter<'a, BorrowEdge<Loc, Lbl>>;
    type Item = &'a BorrowEdge<Loc, Lbl>;

    fn into_iter(self) -> Self::IntoIter {
        debug_assert!(self.overflown || !self.is_empty());
        self.edges.iter()
    }
}
