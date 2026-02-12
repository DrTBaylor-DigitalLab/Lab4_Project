# Lab 4: Hierarchical Design - 4-bit Adder/Subtractor

## Overview

In this lab, you will build a 4-bit adder/subtractor using a hierarchical design methodology. You will construct a complex system by assembling and reusing simpler, verified components - this mirrors real-world engineering practices.

By now you should be comfortable with the Vivado workflow: creating projects, running simulations, synthesizing designs, and programming the Basys 3. In this lab you will apply that workflow to a more complex, multi-module circuit.

Our approach is bottom-up:
1.  **Half Adder**: The most basic building block - adds two single bits.
2.  **Full Adder**: Built from two half adders - handles a carry-in bit for columnar addition.
3.  **Adder/Subtractor**: Four full adders with XOR logic controlled by a mode signal **M**.

When **M=0**, the circuit adds: `A + B`.
When **M=1**, the circuit subtracts using two's complement: `A + ~B + 1 = A - B`.

**Design Hierarchy:**
```
rippleadder (4-bit adder/subtractor - TOP LEVEL)
├── XOR gates (B[i] ^ M → bw[i] for each bit)
├── fulladder_0 (bit 0 - LSB, Cin = M)
├── fulladder_1 (bit 1)
├── fulladder_2 (bit 2)
└── fulladder_3 (bit 3 - MSB)
    └── Each fulladder contains:
        ├── halfadder_0 (A XOR B, A AND B)
        └── halfadder_1 (sum XOR Cin, carry logic)
```

---

## Pre-Lab: Drawing the RTL Diagram

Before writing any Verilog, you will create a **hand-drawn RTL (Register-Transfer Level) diagram** of the complete adder/subtractor circuit. Your instructor will walk you through this process in class.

An RTL diagram is your blueprint for writing Verilog. It adds implementation details that a simple schematic does not:

1.  **Module instances** with unique names (e.g., `fa0`, `fa1`)
2.  **Internal wires** with explicit names (e.g., `bw[0]`, `co[0]`)
3.  **Port connections** showing exactly what connects to what

### Building Blocks Review

#### Half Adder
```
A | B | Sum | Carry
0 | 0 |  0  |   0
0 | 1 |  1  |   0
1 | 0 |  1  |   0
1 | 1 |  0  |   1
```
- Sum = A XOR B
- Carry = A AND B

#### Half Adder Logic Equations
- `Sum = A ^ B` (XOR)
- `Carry = A & B` (AND)

#### Full Adder
```
A | B | Cin | Sum | Cout
0 | 0 |  0  |  0  |  0
0 | 0 |  1  |  1  |  0
0 | 1 |  0  |  1  |  0
0 | 1 |  1  |  0  |  1
1 | 0 |  0  |  1  |  0
1 | 0 |  1  |  0  |  1
1 | 1 |  0  |  0  |  1
1 | 1 |  1  |  1  |  1
```

#### Full Adder Logic Equations
- `Sum = A ^ B ^ Cin` (three-way XOR)
- `Cout = (A & B) | (Cin & (A ^ B))` (carry when two or more inputs are 1)

#### Full Adder from Half Adders

The full adder is built using **two half adders and one OR gate**:
1. **First half adder** adds inputs A and B
2. **Second half adder** adds the sum from the first with Cin
3. **OR gate** combines the carry outputs from both half adders

### The Adder/Subtractor Circuit

The adder/subtractor extends the ripple carry adder with a mode signal **M** and XOR gates on the B inputs:

- Each **B[i]** passes through an XOR gate with **M** to produce **bw[i]**
- When M=0: `bw[i] = B[i]` (passes B through unchanged for addition)
- When M=1: `bw[i] = ~B[i]` (inverts B for subtraction)
- **M** also connects to the carry-in of the first full adder (provides the +1 needed for two's complement)

#### Example: 7 - 3 = 4 (M=1)
- B = `0011`, ~B = `1100`, Cin = 1
- A + ~B + 1 = `0111` + `1100` + `1` = `10100`
- Sum = `0100` (4), Cout = 1

#### Required Deliverable: Hand-Drawn RTL Diagram

**Before writing any Verilog**, draw a complete RTL diagram for the 4-bit adder/subtractor showing:

- [ ] All 4 XOR gates with inputs (B[i], M) and outputs (bw[i])
- [ ] All 4 full adder instances with unique names
- [ ] All internal carry wires with names
- [ ] M connected to both the XOR gates and FA0's carry-in
- [ ] All port connections labeled

Your RTL diagram is the map you will follow when writing your Verilog code. You will present it to your TA during sign-off.

---

## Your Tasks

1. **Draw RTL diagram** - Hand-drawn diagram of the complete adder/subtractor (in-class)
2. **Implement `rtl/halfadder.v`** - Complete the half adder logic
3. **Implement `rtl/fulladder.v`** - Build a full adder from two half adders
4. **Complete `tb/fulladder_tb.v`** - Declare signals, instantiate UUT, and write test vectors
5. **Implement `rtl/rippleadder.v`** - XOR gates, carry chain, and four full adders
6. **Complete `rtl/adder_wrapper.v`** - Instantiate the rippleadder
7. **Simulate and test** - Verify all modules in Vivado
8. **Program the Basys 3** - Validate on hardware with addition and subtraction

---

## Lab Activities

### Step 1: Vivado Project Setup
- [ ] Download the Lab 4 template files
- [ ] Launch Vivado and create a new project
- [ ] Set the project location *outside* of the template directory
- [ ] Add all `.v` files from `rtl/` as **design sources**
- [ ] Add all testbench files from `tb/` as **simulation sources**
- [ ] Add the constraint file from `constraints/`
- [ ] Select the Basys3 board as target

### Step 2: The Half Adder
- [ ] Open `rtl/halfadder.v` and implement the logic
- [ ] Set `halfadder_tb` as the simulation top module and run simulation
- [ ] Verify all 4 test cases pass
- [ ] **A working half adder is required for all subsequent steps**

### Step 3: The Full Adder
- [ ] Open `rtl/fulladder.v` and implement using two `halfadder` instances
- [ ] Open `tb/fulladder_tb.v` and complete the 3 TODO sections:
  - Declare input and output signals
  - Instantiate the fulladder as `UUT`
  - Write all 8 test vectors
- [ ] Set `fulladder_tb` as simulation top and run simulation
- [ ] **Debug both files until all 8 test cases pass**

### Step 4: The 4-bit Adder/Subtractor
- [ ] Open `rtl/rippleadder.v` and implement the XOR gates and full adder chain
- [ ] Use your hand-drawn RTL diagram as your guide - translate it directly to Verilog
- [ ] Set `rippleadder_tb` as simulation top and run simulation
- [ ] Verify all 12 test cases pass (6 addition + 6 subtraction)

### Step 5: Hardware Implementation
- [ ] Complete `rtl/adder_wrapper.v` with the rippleadder instantiation
- [ ] Set `adder_wrapper` as the top-level module for synthesis
- [ ] Synthesize, implement, and generate bitstream
- [ ] Program the Basys 3 and test with the cases below

---

## Checking Your Work

When you push your code, GitHub Actions will automatically compile and test each module:

| CI Job | What It Tests | Files Compiled |
|--------|--------------|----------------|
| `test-halfadder` | Half adder in isolation | `halfadder.v` + `halfadder_tb.v` |
| `test-fulladder` | Full adder (uses half adder) | `halfadder.v` + `fulladder.v` + `fulladder_tb.v` |
| `test-rippleadder` | Full adder/subtractor system | `halfadder.v` + `fulladder.v` + `rippleadder.v` + `rippleadder_tb.v` |

All three jobs must show **TEST PASSED** for full credit.

---

## Hardware Interface

### Switch Assignment
- `sw[3:0]` = A[3:0] (first 4-bit number)
- `sw[7:4]` = B[3:0] (second 4-bit number)
- `sw[15]` = M (mode: down = add, up = subtract)

### LED Assignment
- `led[7:0]` mirrors `sw[7:0]` (confirms your inputs)
- `led[8]` shows M (mode indicator)
- `led[14:11]` displays the 4-bit Sum
- `led[15]` displays Cout

---

## Example Test Cases

### Addition (sw[15] = 0)

| A (sw[3:0]) | B (sw[7:4]) | Sum (led[14:11]) | Cout (led[15]) | Notes |
|-------------|-------------|-------------------|----------------|-------|
| 3 | 2 | 5 | 0 | Basic addition |
| 5 | 7 | 12 | 0 | Carries within 4 bits |
| 7 | 8 | 15 | 0 | Maximum without overflow |
| 15 | 1 | 0 | 1 | Overflow: 16 wraps to 0 |

### Subtraction (sw[15] = 1)

| A (sw[3:0]) | B (sw[7:4]) | Sum (led[14:11]) | Cout (led[15]) | Notes |
|-------------|-------------|-------------------|----------------|-------|
| 5 | 3 | 2 | 1 | Basic subtraction |
| 7 | 7 | 0 | 1 | Equal values |
| 8 | 3 | 5 | 1 | Larger minus smaller |
| 0 | 1 | 15 | 0 | Borrow: result wraps |
| 3 | 8 | 11 | 0 | Borrow: A < B |

> **Note:** In subtraction mode, Cout=1 means **no borrow** (A >= B). Cout=0 means **borrow occurred** (A < B) and the result has wrapped around.

---

## File Structure

```
├── rtl/
│   ├── halfadder.v       # Half adder (you implement)
│   ├── fulladder.v       # Full adder using half adders (you implement)
│   ├── rippleadder.v     # 4-bit adder/subtractor (you implement)
│   └── adder_wrapper.v   # FPGA interface wrapper (you complete)
├── tb/
│   ├── halfadder_tb.v    # Half adder testbench (provided)
│   ├── fulladder_tb.v    # Full adder testbench (you complete)
│   └── rippleadder_tb.v  # Adder/subtractor testbench (provided)
├── constraints/
│   └── basys3.xdc        # Pin assignments for Basys3
└── .github/workflows/
    └── test.yml           # CI - auto-tests on push
```

---

## Common Issues and Troubleshooting

### Synthesis Errors
- Check that all module names match between files
- Verify that all wires are properly declared
- Ensure proper port connections in instantiations
- **Case sensitivity**: `Cout` is different from `cout` - names must match exactly

### Simulation Issues
- Wrong testbench set as the simulation top
- Incorrect testbench stimulus timing
- Wrong expected results in comparisons

### Hardware Issues
- Wrong switch/LED assignments - check constraint file
- Bitstream not loading - verify board connection
- Unexpected results - verify logic in simulation first

