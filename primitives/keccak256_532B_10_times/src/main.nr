use dep::std;

/*
+-------------------------+----------------------+--------------+----------------------+
| Package                 | Expression Width     | ACIR Opcodes | Backend Circuit Size |
+-------------------------+----------------------+--------------+----------------------+
| keccak256_532B_10_times | Bounded { width: 3 } | 8849         | 761974               |
+-------------------------+----------------------+--------------+----------------------+
*/

global TRIE_NODE_LEN: u32 = 532;
global TIMES: u32 = 10;

fn main(trie_nodes: [[u8; TRIE_NODE_LEN]; TIMES]) -> pub [u8; 32] {
    let mut to_hash = [0; 32];
    for n in 0..TIMES {
        let mut trie_node = trie_nodes[n];
        let hash = std::hash::keccak256(trie_node, TRIE_NODE_LEN);
        for i in 0..32 {
            to_hash[i] = std::wrapping_add(to_hash[i], hash[i]);
        }
    }
    to_hash
}
