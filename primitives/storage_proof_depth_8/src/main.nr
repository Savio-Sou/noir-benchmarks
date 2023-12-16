use dep::trie;
use dep::std::hash::keccak256;

global DEPTH8_MAX: Field = 4256;

// Forked from https://github.com/aragonzkresearch/noir-trie-proofs/blob/ee20882bdd8914278c8a59002d7ec36a6f7d0fbb/tests/depth_8_storage_proof/src/main.nr

/*
+-----------------------+------------------------+--------------+----------------------+
| Package               | Language               | ACIR Opcodes | Backend Circuit Size |
+-----------------------+------------------------+--------------+----------------------+
| depth_8_storage_proof | PLONKCSat { width: 3 } | 51563        | 1687738              |
+-----------------------+------------------------+--------------+----------------------+
*/

fn main(storage_root: pub [u8; 32], storage_proof: trie::StorageProof<DEPTH8_MAX>) {
    assert(storage_proof.verify_storage_root(storage_root));
}
