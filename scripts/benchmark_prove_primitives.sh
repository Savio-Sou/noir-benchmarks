#!/bin/bash

# Specify the base commands
base_command="nargo prove --package "

# Generate a sequence of arguments for all primitives
arguments=("keccak256_32B" "keccak256_32B_100_times" "ecdsa_secp256k1" "compute_merkle_root_depth_4" "compute_merkle_root_depth_32" "verify_proof" "storage_proof_depth_8")

# Specify the output CSV file
output_csv="results/prove_primitives.csv"

# Clear the contents of the output CSV file and write headers
echo "Primitive,\`nargo prove\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct the full commands
    full_command="$base_command$args"

    # Print the command before timing
    echo "Running: $full_command"

    # Run the command and capture the timing information
    { time_output=$({ time $full_command; } 2>&1); }

    # Extract real time from time_output using awk
    real_time=$(echo "$time_output" | awk '/real/ {print $NF}')

    # Log the results to the CSV file
    echo "$args,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"