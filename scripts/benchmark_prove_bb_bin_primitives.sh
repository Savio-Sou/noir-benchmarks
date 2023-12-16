#!/bin/bash

# Generate a sequence of arguments for all primitives
arguments=("keccak256" "keccak256_100_times" "ecdsa_secp256k1" "compute_merkle_root_depth_4" "compute_merkle_root_depth_32" "verify_proof" "storage_proof_depth_8" "rsa")

# Specify the output CSV file
output_csv="results/prove_bb_bin_primitives.csv"

# Clear the contents of the output CSV file and write headers
echo "Primitive,\`backend_binary prove\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct commands
    encode_command="jq -r '.bytecode' ./target/$args.json | base64 -d > ./target/$args.gz"
    prove_command="$HOME/.nargo/backends/acvm-backend-barretenberg/backend_binary prove -b ./target/$args.gz -w ./target/witness_$args.gz -o ./proofs/${args}_bb_bin.proof"

    # Preprocess files
    echo "Running: $encode_command"
    eval "$encode_command"

    # Print the execute command before timing
    echo "Running: $prove_command"

    # Run the execute command and capture the timing information along with any error message
    { time_output=$({ time $prove_command; } 2>&1); }

    # Extract real time from time_output using awk
    real_time=$(echo "$time_output" | awk '/real/ {print $NF}')

    # Log the results to the CSV file
    echo "$args,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"