use dep::trie;
use dep::std::hash::keccak256;

global DEPTH8_MAX: Field = 4256;

// Forked from https://github.com/aragonzkresearch/noir-trie-proofs/blob/ee20882bdd8914278c8a59002d7ec36a6f7d0fbb/tests/depth_8_storage_proof/src/main.nr

/*
+-----------------------+------------------------+--------------+----------------------+
| Package               | Language               | ACIR Opcodes | Backend Circuit Size |
+-----------------------+------------------------+--------------+----------------------+
| storage_proof_depth_8 | PLONKCSat { width: 3 } | 55880        | 1802223              |
+-----------------------+------------------------+--------------+----------------------+
*/

fn main(
    state_root: pub [u8; 32],
    state_proof: trie::TrieProof<20, DEPTH8_MAX, trie::MAX_ACCOUNT_STATE_LENGTH>
) {
    assert(state_proof.verify_state_root(state_root));
}
