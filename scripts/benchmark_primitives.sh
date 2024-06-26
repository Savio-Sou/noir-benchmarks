#!/bin/bash

# Generate a sequence of packages for all primitives
export PACKAGES="keccak256_32B keccak256_32B_100_times keccak256_532B keccak256_532B_10_times ecdsa_secp256k1 compute_merkle_root_depth_4 compute_merkle_root_depth_32 verify_proof storage_proof_depth_8"

bash scripts/benchmark_compile_primitives.sh
bash scripts/benchmark_execute_primitives.sh
bash scripts/benchmark_prove_bb_bin_primitives.sh
bash scripts/benchmark_prove_primitives.sh