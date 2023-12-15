use dep::std::hash::sha256;
use dep::biguint::{BigUint56};
use dep::rsa::{verify_sha256_pkcs1v15};

/*
+---------+------------------------+--------------+----------------------+
| Package | Language               | ACIR Opcodes | Backend Circuit Size |
+---------+------------------------+--------------+----------------------+
| rsa     | PLONKCSat { width: 3 } | 1642330      | 3020035              |
+---------+------------------------+--------------+----------------------+
*/

fn main(message: [u8; 177], dkim_sig: BigUint56, modulus: BigUint56) {
    let hashed_message = sha256(message);

    let pubkey_e = BigUint56 {
        limbs: [
            65537, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0
        ]
    };

    verify_sha256_pkcs1v15(hashed_message, dkim_sig, pubkey_e, modulus);
}
