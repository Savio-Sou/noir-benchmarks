#!/bin/bash

# Generate a sequence of arguments from 2 to 24
arguments=($(seq 2 24))

# Specify the output CSV file
output_csv="results/m3-pro-12-arm/execute.csv"

# Clear the contents of the output CSV file and write headers
echo "Backend Circuit Size,\`nargo execute\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct the full commands
    command="nargo execute witness_2^$args --package 2^$args"

    # Print the execute command before timing
    echo "Running: $command"

    # Run the execute command and capture the timing information
    { time_output=$({ time $command; } 2>&1); }

    # Extract real time from time_output using awk
    real_time=$(echo "$time_output" | awk '/real/ {print $NF}')

    # Log the results to the CSV file
    echo "2^$args,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"