use dep::std;

/*
+--------------+------------------------+--------------+----------------------+
| Package      | Language               | ACIR Opcodes | Backend Circuit Size |
+--------------+------------------------+--------------+----------------------+
| verify_proof | PLONKCSat { width: 3 } | 1            | 247869               |
+--------------+------------------------+--------------+----------------------+
*/

fn main(
    verification_key: [Field; 114],
    proof: [Field; 94],
    public_inputs: [Field; 1],
    key_hash: Field,
    input_aggregation_object: [Field; 16]
) -> pub [Field; 16] {
    std::verify_proof(
        verification_key.as_slice(),
        proof.as_slice(),
        public_inputs.as_slice(),
        key_hash,
        input_aggregation_object
    )
}
