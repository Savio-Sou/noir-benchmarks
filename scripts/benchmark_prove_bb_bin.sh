#!/bin/bash

# Generate a sequence of arguments from 2 to 24
arguments=($(seq 2 24))

# Specify the output CSV file
output_csv="results/prove_bb_bin.csv"

# Clear the contents of the output CSV file and write headers
echo "Backend Circuit Size,\`backend_binary prove\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct commands
    encode_command="jq -r '.bytecode' ./target/2^$args.json | base64 -d > ./target/2^$args.gz"
    prove_command="$HOME/.nargo/backends/acvm-backend-barretenberg/backend_binary prove -b ./target/2^$args.gz -w ./target/witness_2^$args.gz -o ./proofs/2^${args}_bb_bin.proof"

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
    echo "2^$args,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"