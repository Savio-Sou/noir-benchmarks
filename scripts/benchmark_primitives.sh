#!/bin/bash

# Generate a sequence of packages for all primitives
#export PACKAGES="keccak256_32B keccak256_32B_100_times keccak256_532B keccak256_532B_10_times ecdsa_secp256k1 compute_merkle_root_depth_4 compute_merkle_root_depth_32 verify_proof storage_proof_depth_8"

# The following have been omitted as they don't work
# storage_proof_depth_8: depends on aragonzkresearch/noir-trie-proofs, which has not yet been updates for nargo v1.0.0-beta.0
# verify_proof: emits the following error:

# bb: /home/runner/work/aztec-packages/aztec-packages/barretenberg/cpp/src/barretenberg/ecc/curves/bn254/../../fields/./field_declarations.hpp:128: bool bb::field<bb::Bn254FrParams>::operator bool() const [Params = bb::Bn254FrParams]: Assertion `(out.data[0] == 0 || out.data[0] == 1)' failed.
# Aborted (core dumped)

export PACKAGES="keccak256_32B keccak256_32B_100_times keccak256_532B keccak256_532B_10_times ecdsa_secp256k1 compute_merkle_root_depth_4 compute_merkle_root_depth_32"

bash scripts/benchmark_compile_primitives.sh
bash scripts/benchmark_execute_primitives.sh
bash scripts/benchmark_prove_bb_bin_primitives.sh
