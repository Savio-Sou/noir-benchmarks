# Noir Benchmarks

Benchmarks for `nargo compile`, `nargo execute`, and `bb prove_ultra_honk` over
Noir programs spanning across different constraint counts (i.e. program sizes).

Results gathered with:

- Nargo 1.0.0-beta.0
- Barretenberg 0.63.0
- Lenovo Thinkpad P16 Gen 2 with [13th Gen Intel(R) Core(TM)
  i7-13700HX](https://www.intel.com/content/www/us/en/products/sku/232166/intel-core-i713700hx-processor-30m-cache-up-to-5-00-ghz/specifications.html)
- Ubuntu Linux 23.04

# Nargo v1.0.0-beta.0 and bb 0.63.0 Results

![Results on Thinkpad P16 Gen 2](Thinkpad_P16_Gen2_v1.0.0-beta.0.png)

| Primitive                    | Backend Circuit Size | Compile Time (s) | Execute Time (s) | Prove Time (s) |
|------------------------------|:--------------------:|:----------------:|:----------------:|:--------------:|
| keccak256_32B                |                20240 |            0.160 |            0.150 |          0.911 |
| keccak256_32B_100_times      |              1733534 |            0.791 |            0.278 |         18.299 |
| keccak256_532B               |                76817 |            0.252 |            0.168 |          1.429 |
| keccak256_532B_10_times      |               747646 |            0.955 |            0.350 |          8.316 |
| ecdsa_secp256k1              |                39324 |            0.162 |            0.154 |          0.893 |
| compute_merkle_root_depth_4  |                 3223 |            0.154 |            0.148 |          0.620 |
| compute_merkle_root_depth_32 |                 7517 |            0.159 |            0.166 |          0.720 |

`verify_proof` and `storage_proof_depth_8` were omitted as I ran into issues with v1.0.0-beta.0. Specifically.
storage_proof_depth_8 depends on
[aragonzkresearch/noir-trie-proofs](https://github.com/aragonzkresearch/noir-trie-proofs),
which, at the time of writing, has not yet been updates for nargo
v1.0.0-beta.0. Furthermore running `bb` to generate the recurvsive proof
(`verify_proof`) emitted the following error:

```
bb: /home/runner/work/aztec-packages/aztec-packages/barretenberg/cpp/src/barretenberg/ecc/curves/bn254/../../fields/./field_declarations.hpp:128: bool bb::field<bb::Bn254FrParams>::operator bool() const [Params = bb::Bn254FrParams]: Assertion `(out.data[0] == 0 || out.data[0] == 1)' failed.
Aborted (core dumped)
```

| Backend Circuit Size | Compile Time (s) | Execute Time (s) |        Prove Time (s)       |
|:--------------------:|:----------------:|:----------------:|:---------------------------:|
| 2^2                  |          0.170   |          0.158   |                      0.428  |
| 2^3                  |          0.151   |          0.149   |                      0.430  |
| 2^4                  |          0.145   |          0.152   |                      0.430  |
| 2^5                  |          0.144   |          0.151   |                      0.443  |
| 2^6                  |          0.146   |          0.145   |                      0.440  |
| 2^7                  |          0.148   |          0.154   |                      0.443  |
| 2^8                  |          0.156   |          0.150   |                      0.441  |
| 2^9                  |          0.160   |          0.153   |                      0.459  |
| 2^10                 |          0.156   |          0.175   |                      0.477  |
| 2^11                 |          0.159   |          0.185   |                      0.486  |
| 2^12                 |          0.175   |          0.212   |                      0.524  |
| 2^13                 |          0.212   |          0.278   |                      0.607  |
| 2^14                 |          0.272   |          0.402   |                      0.773  |
| 2^15                 |          0.428   |          0.687   |                      1.127  |
| 2^16                 |          0.709   |          1.223   |                      1.726  |
| 2^17                 |          1.268   |          2.374   |                      2.956  |
| 2^18                 |          2.612   |          4.813   |                      5.426  |
| 2^19                 |          5.238   |          9.729   |                      10.331 |
| 2^20                 |          10.468  |          19.530  |                      20.255 |
| 2^21                 |          20.230  |          38.190  |                      39.531 |
| 2^22                 |          42.490  |          78.707  |                      77.385 |
| 2^23                 |          81.991  |          154.556 |                           * |
| 2^24                 |          166.043 |          366.101 |                           * |

Note that for the entries marked with \*, the `bb` program emitted the
following error, indicating that the device likely ran out of memory:

```
libc++abi: terminating due to uncaught exception of type std::bad_alloc: std::bad_alloc
Aborted (core dumped)
```

## Old results

A previous version of these benchmarks used older version of Nargo and the Barretenberg backend.

### v0.26.0 Results

Results gathered with:
- M1 Max Macbook Pro
- Nargo v0.26.0 paired with the default [barretenberg](https://github.com/AztecProtocol/aztec-packages/tree/master/barretenberg) proving backend

| Primitive                    | Backend Circuit Size | Compile Time (s) | Execute Time (s) | Prove Time (s) | Execute + Prove Time (s) |
|------------------------------|:--------------------:|:----------------:|:----------------:|:--------------:|:------------------------:|
| keccak256_32B                |               54,830 |            0.248 |            0.283 |          1.586 |                    1.869 |
| keccak256_32B_100_times      |            1,829,949 |            0.227 |            0.286 |         36.157 |                   36.443 |
| keccak256_532B               |               97,766 |            0.228 |            0.282 |          2.771 |                    3.053 |
| keccak256_532B_10_times      |              761,974 |            0.256 |            0.354 |         17.475 |                   17.829 |
| ecdsa_secp256k1              |               36,355 |            0.219 |            0.281 |          1.623 |                    1.904 |
| compute_merkle_root_depth_4  |               28,858 |            0.217 |            0.280 |          1.044 |                    1.324 |
| compute_merkle_root_depth_32 |               30,482 |            0.229 |            0.299 |          1.081 |                    1.380 |
| verify_proof                 |              257,427 |            0.219 |            0.291 |          5.262 |                    5.553 |
| storage_proof_depth_8        |            1,686,784 |            0.578 |            1.501 |         34.708 |                   36.209 |

### v0.21.0 Results

Results gathered with:
- M2 Macbook Air
- Nargo v0.21.0 paired with the default [barretenberg](https://github.com/AztecProtocol/aztec-packages/tree/master/barretenberg) proving backend

| Primitive                    | Backend Circuit Size | Compile Time (s) | Execute Time (s) | Prove Time (s) | Execute + Prove Time (s) |
|------------------------------|:--------------------:|:----------------:|:----------------:|:--------------:|:------------------------:|
| keccak256                    |               55,000 |            0.308 |            0.381 |          2.238 |                    2.823 |
| keccak256_100_times          |            1,800,000 |              0.3 |            0.384 |         78.813 |                   84.236 |
| ecdsa_secp256k1              |               35,000 |            0.299 |            0.371 |           2.43 |                    3.081 |
| compute_merkle_root_depth_4  |               29,000 |            0.296 |            0.376 |           1.12 |                    1.656 |
| compute_merkle_root_depth_32 |               30,000 |              0.3 |            0.389 |          1.164 |                    1.695 |
| verify_proof                 |              250,000 |            0.298 |            0.381 |         10.756 |                   11.811 |
| storage_proof_depth_8        |            1,700,000 |            1.873 |            1.133 |         78.635 |                    84.61 |
| [rsa](https://github.com/Savio-Sou/noir-benchmarks/tree/9b71b34cea654102abcd35f3540d0dfb17892baf/primitives/rsa)                          |            3,000,000 |           29.061 |           109.31 |        177.779 |                  287.202 |

![Results on M2 Macbook Air](M2_Air_Nargo_v0.21.0.png)

| Backend Circuit Size | Compile Time (s) | Execute Time (s) |        Prove Time (s)       | Execute + Prove Time (s) |
|:--------------------:|:----------------:|:----------------:|:---------------------------:|:------------------------:|
| 2^2                  |            0.317 |            0.405 |                       0.092 |                    0.474 |
| 2^3                  |            0.296 |            0.392 |                       0.062 |                    0.473 |
| 2^4                  |            0.296 |            0.381 |                       0.069 |                    0.474 |
| 2^5                  |            0.297 |            0.381 |                       0.087 |                    0.492 |
| 2^6                  |            0.297 |            0.379 |                       0.097 |                    0.501 |
| 2^7                  |            0.296 |            0.381 |                       0.103 |                     0.51 |
| 2^8                  |            0.298 |            0.379 |                       0.113 |                    0.517 |
| 2^9                  |            0.299 |            0.403 |                        0.14 |                    0.571 |
| 2^10                 |            0.313 |            0.386 |                       0.191 |                    0.614 |
| 2^11                 |            0.321 |            0.408 |                        0.26 |                     0.71 |
| 2^12                 |            0.328 |            0.427 |                       0.415 |                    0.892 |
| 2^13                 |            0.365 |            0.476 |                       0.702 |                    1.218 |
| 2^14                 |            0.436 |            0.596 |                       1.255 |                    1.882 |
| 2^15                 |            0.533 |             0.79 |                       2.389 |                    3.184 |
| 2^16                 |            1.175 |            1.219 |                       4.627 |                    6.362 |
| 2^17                 |            2.137 |            2.054 |                       9.075 |                   12.022 |
| 2^18                 |            4.057 |            3.745 |                      18.368 |                   23.328 |
| 2^19                 |            8.235 |            7.219 |                       37.65 |                   46.248 |
| 2^20                 |           17.365 |           14.188 |                      77.025 |                   92.999 |
| 2^21                 |           36.593 |           28.024 |                     177.603 |                  215.753 |
| 2^22                 |           81.102 |           56.556 | Failed to download g1 data. |                          |
| 2^23                 |           178.06 |             87.2 |                             |                          |
| 2^24                 |          839.978 |          245.025 |                             |                          |

Detailed results are available in the [`results`](./results/) folder.

A Noir user flow typically starts from developers compiling and distributing the compiled artifacts as a part of their applications to users, where users then execute the application and prove their execution. Execute and Prove times combined hence represents what application users are expected to experience when interacting with applications built with Noir.

The "Execute + Prove Time"s above were gathered through running `nargo prove`, which not only does execution and proving but also additional minor tasks that might contribute to the differences between simply summing "Execute" and "Prove" times up.

## Run it yourself

To gather your own results:

1. [Install Nargo](https://noir-lang.org/getting_started/nargo_installation).
2. [Install  Barretenberg](https://github.com/AztecProtocol/barretenberg).

Next, run from the project root:

```
bash scripts/benchmark_all.sh
```

You can then find the results being printed into the CSV file under the [`results`](./results/) folder.

**Note:** The first run includes program compilations. Conduct a second run to obtain accurate benchmarks of `nargo prove` times.

## Contribute

If you would like to share results from your local runs, submit a Pull Request specifying:

- Hardware specifications / model
- Nargo version used
- Proving backend used

## 2^n constraint counts

Ultraplonk-based barretenberg comes with stepped proving time and memory footprints per powers of 2 constraint counts. That is two Noir programs of 150,000 and 250,000 backend constraint counts respectively would cost similar time and memory to prove, as they both consist of >2^17 and ≤2^18 constraints.

The repository contains Noir programs of backend constraint counts from 2^2 to 2^24.

You can run the following command at the project root to verify actual constraint counts of each example program:

```
./scripts/info.sh
```

You should then see the corresponding details saved to `results/info_results.txt`:

```
Running: nargo info --package 2^2
+---------+----------+----------------------+--------------+-----------------+
| Package | Function | Expression Width     | ACIR Opcodes | Brillig Opcodes |
+---------+----------+----------------------+--------------+-----------------+
| 2^2     | main     | Bounded { width: 4 } | 0            | 0               |
+---------+----------+----------------------+--------------+-----------------+
----------------------------------------------------
Running: nargo info --package 2^3
+---------+------------------+----------------------+--------------+-----------------+
| Package | Function         | Expression Width     | ACIR Opcodes | Brillig Opcodes |
+---------+------------------+----------------------+--------------+-----------------+
| 2^3     | main             | Bounded { width: 4 } | 4            | 9               |
+---------+------------------+----------------------+--------------+-----------------+
| 2^3     | directive_invert | N/A                  | N/A          | 9               |
+---------+------------------+----------------------+--------------+-----------------+
----------------------------------------------------
Running: nargo info --package 2^4
+---------+------------------+----------------------+--------------+-----------------+
| Package | Function         | Expression Width     | ACIR Opcodes | Brillig Opcodes |
+---------+------------------+----------------------+--------------+-----------------+
| 2^4     | main             | Bounded { width: 4 } | 18           | 9               |
+---------+------------------+----------------------+--------------+-----------------+
| 2^4     | directive_invert | N/A                  | N/A          | 9               |
+---------+------------------+----------------------+--------------+-----------------+
----------------------------------------------------

... (continued)
```
