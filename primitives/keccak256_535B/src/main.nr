use dep::std;

global TRIE_NODE_LEN = 535;

fn main(trie_node: [u8; TRIE_NODE_LEN]) -> pub [u8; 32] {
    std::hash::keccak256(trie_node, TRIE_NODE_LEN)
}
