use dep::std;

/*
+-----------------------------+------------------------+--------------+----------------------+
| Package                     | Language               | ACIR Opcodes | Backend Circuit Size |
+-----------------------------+------------------------+--------------+----------------------+
| compute_merkle_root_depth_4 | PLONKCSat { width: 3 } | 30           | 28858                |
+-----------------------------+------------------------+--------------+----------------------+
*/

fn main(leaf : Field, index : Field, hash_path: [Field; 3]) -> pub Field {
    std::merkle::compute_merkle_root(leaf, index, hash_path)
}
