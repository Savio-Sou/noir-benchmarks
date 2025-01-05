use dep::std;

/*
+----------------+----------------------+--------------+----------------------+
| Package        | Expression Width     | ACIR Opcodes | Backend Circuit Size |
+----------------+----------------------+--------------+----------------------+
| keccak256_532B | Bounded { width: 3 } | 537          | 97766                |
+----------------+----------------------+--------------+----------------------+
*/

global TRIE_NODE_LEN: u32 = 532;

fn main(trie_node: [u8; TRIE_NODE_LEN]) -> pub [u8; 32] {
    std::hash::keccak256(trie_node, TRIE_NODE_LEN)
}
