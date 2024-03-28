#!/bin/bash

# Specify the base commands
base_command="nargo execute --package "

# Generate a sequence of packages for all primitives
packages=("keccak256_32B" "keccak256_32B_100_times" "ecdsa_secp256k1" "compute_merkle_root_depth_4" "compute_merkle_root_depth_32" "verify_proof" "storage_proof_depth_8")

# Specify the output CSV file
output_csv="results/execute_primitives.csv"

# Clear the contents of the output CSV file and write headers
echo "Primitive,\`nargo execute\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of packages
for pkg in "${packages[@]}"; do
    # Construct the full commands
    command="nargo execute witness_$pkg --package $pkg"

    # Print the execute command before timing
    echo "Running: $command"

    # Run the execute command and capture the timing information
    { time_output=$({ time $command; } 2>&1); }

    # Extract real time from time_output using awk
    real_time=$(echo "$time_output" | awk '/real/ {print $NF}')

    # Log the results to the CSV file
    echo "$pkg,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"