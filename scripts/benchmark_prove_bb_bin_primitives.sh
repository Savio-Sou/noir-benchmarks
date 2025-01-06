#!/bin/bash

set -e

# Specify the output CSV file
output_csv="results/prove_bb_bin_primitives.csv"

# Clear the contents of the output CSV file and write headers
echo "Primitive,\`backend_binary prove\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of packages
for pkg in $PACKAGES; do
    # Construct commands
    encode_command="jq -r '.bytecode' ./target/$pkg.json | base64 -d > ./target/$pkg.gz"
    prove_command="bb prove_ultra_honk -b ./target/$pkg.gz -w ./target/witness_$pkg.gz -o ./proofs/${pkg}_bb_bin.proof"

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
    echo "$pkg,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"
