#!/bin/bash
# Does not successfully extract backend circuit sizes.

# Specify the base commands
info_base_command="nargo info --package 2^"
prove_base_command="nargo prove --package 2^"

# Generate a sequence of arguments from 2 to 24
arguments=($(seq 2 24))

# Specify the output CSV file
output_csv="results/info_and_prove_results.csv"

# Clear the contents of the output CSV file and write headers
echo "Backend Circuit Size (2^n),\`nargo prove\` Time (s)" > "$output_csv"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct the full commands
    info_full_command="$info_base_command$args"
    prove_full_command="$prove_base_command$args"

    # Run the info command and capture its output
    info_output=$(eval "$info_full_command")

    # Print the prove command before timing
    echo "Running: $prove_full_command"

    # Run the prove command and capture the timing information
    { time_output=$({ time $prove_full_command; } 2>&1); }

    # Extract real time from time_output using awk
    real_time=$(echo "$time_output" | awk '/real/ {print $NF}')

    # Log the results to the CSV file
    echo "2^$args,$real_time" >> "$output_csv"

    # Print a separator line after each command
    print_separator
done

echo "Results have been saved to $output_csv"