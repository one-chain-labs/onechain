module a::b;

fun f() {
    let x = one::dynamic_field::borrow<vector<u8>, u64>(&parent, b"");
    let x = ::one::dynamic_field::borrow<vector<u8>, u64>(&parent, b"");
}
