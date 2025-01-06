#!/bin/bash

set -e

# Specify the base commands
base_command="nargo execute --package "

# Specify the output CSV file
output_csv="results/execute_primitives.csv"

# Clear the contents of the output CSV file and write headers
echo "Primitive,\`nargo execute\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of packages
for pkg in $PACKAGES; do
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
