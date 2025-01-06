#!/bin/bash

set -e

# Specify the base commands
info_base_command="nargo info --package "

# Generate a sequence of packages from 2 to 24
packages=($(seq 2 24))
primitive_packages=(keccak256_32B keccak256_32B_100_times keccak256_532B keccak256_532B_10_times ecdsa_secp256k1 compute_merkle_root_depth_4 compute_merkle_root_depth_32)

# Specify the output file
output_file="results/info_results.txt"

# Clear the contents of the output file
echo "" > "$output_file"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------" >> "$output_file"
}

# Iterate through each set of packages
for pkg in "${packages[@]}"; do
    # Construct the full commands
    info_full_command="$info_base_command 2\^$pkg"

    # Print the info command before timing
    echo "Running: $info_full_command" >> "$output_file"
    
    # Run the info command and capture its output
    info_output=$(eval "$info_full_command")
    echo "$info_output" >> "$output_file"

    # Print a separator line after each command
    print_separator
done

for pkg in "${primitive_packages[@]}"; do
    # Construct the full commands
    info_full_command="$info_base_command$pkg"

    # Print the info command before timing
    echo "Running: $info_full_command" >> "$output_file"
    
    # Run the info command and capture its output
    info_output=$(eval "$info_full_command")
    echo "$info_output" >> "$output_file"

    # Print a separator line after each command
    print_separator
done

echo "Info results have been saved to $output_file"
