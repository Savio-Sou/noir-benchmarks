use dep::std;

/*
+------------------------------+------------------------+--------------+----------------------+
| Package                      | Language               | ACIR Opcodes | Backend Circuit Size |
+------------------------------+------------------------+--------------+----------------------+
| compute_merkle_root_depth_32 | PLONKCSat { width: 3 } | 310          | 30482                |
+------------------------------+------------------------+--------------+----------------------+
*/

fn main(leaf: Field, index: Field, hash_path: [Field; 31]) -> pub Field {
    std::merkle::compute_merkle_root(leaf, index, hash_path)
}
