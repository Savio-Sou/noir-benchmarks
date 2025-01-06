#!/bin/bash

mkdir -p results

bash scripts/benchmark_circuit_sizes.sh
bash scripts/benchmark_primitives.sh
