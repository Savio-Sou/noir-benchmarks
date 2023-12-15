use dep::std;

/*
+---------------------+------------------------+--------------+----------------------+
| Package             | Language               | ACIR Opcodes | Backend Circuit Size |
+---------------------+------------------------+--------------+----------------------+
| compute_merkle_root | PLONKCSat { width: 3 } | 30           | 28858                |
+---------------------+------------------------+--------------+----------------------+
*/

fn main(leaf: Field, index: Field, hash_path: [Field; 31]) -> pub Field {
    std::merkle::compute_merkle_root(leaf, index, hash_path)
}
