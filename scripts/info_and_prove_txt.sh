#!/bin/bash

# Specify the base commands
info_base_command="nargo info --package 2^"
prove_base_command="nargo prove --package 2^"

# Generate a sequence of arguments from 2 to 24
arguments=($(seq 2 24))

# Specify the output file
output_file="results/info_and_prove_results.txt"

# Clear the contents of the output file
echo "" > "$output_file"

# Function to print a separator line
print_separator() {
    echo "----------------------------------------------------" >> "$output_file"
}

# Iterate through each set of arguments
for args in "${arguments[@]}"; do
    # Construct the full commands
    info_full_command="$info_base_command$args"
    prove_full_command="$prove_base_command$args"

    # Print the info command before timing
    echo "Running: $info_full_command" >> "$output_file"
    
    # Run the info command and capture its output
    info_output=$(eval "$info_full_command")
    echo "$info_output" >> "$output_file"

    # Print the prove command before timing
    echo "Running: $prove_full_command" >> "$output_file"
    
    # Run the prove command and capture the timing information
    { time $prove_full_command; } 2>> "$output_file"

    # Print a separator line after each command
    print_separator
done

echo "Timing results have been saved to $output_file"