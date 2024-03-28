use dep::std;

/*
+-------------------------+----------------------+--------------+----------------------+
| Package                 | Expression Width     | ACIR Opcodes | Backend Circuit Size |
+-------------------------+----------------------+--------------+----------------------+
| keccak256_32B_100_times | Bounded { width: 3 } | 133          | 1829949              |
+-------------------------+----------------------+--------------+----------------------+
*/

fn main(message: [u8; 32]) -> pub [u8; 32] {
    let mut to_hash = message;
    for _ in 0..100 {
        to_hash = std::hash::keccak256(to_hash, 32);
    }
    to_hash
}
