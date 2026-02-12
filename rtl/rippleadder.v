// rippleadder.v - 4-bit Ripple Carry Adder/Subtractor
// Lab 4: Hierarchical Design - Top Level Module
//
// Adds or subtracts two 4-bit numbers using a chain of full adders.
// When M=0: computes A + B (addition)
// When M=1: computes A - B (subtraction via two's complement)
//
// Subtraction works by inverting B (XOR with M=1) and adding 1 (M into Cin).
// This computes A + ~B + 1 = A - B
//
// Example addition: 5 + 3 = 8
//   M = 0, A = 4'b0101 (5), B = 4'b0011 (3)
//   Sum = 4'b1000 (8), Cout = 0
//
// Example subtraction: 7 - 3 = 4
//   M = 1, A = 4'b0111 (7), B = 4'b0011 (3)
//   Sum = 4'b0100 (4), Cout = 1

module rippleadder(
    input  [3:0] A,    // 4-bit input A
    input  [3:0] B,    // 4-bit input B
    input        M,    // Mode: 0 = add, 1 = subtract
    output [3:0] Sum,  // 4-bit result
    output       Cout  // Carry out
);

    // TODO: Declare internal wires (bw for XOR'd B, carry wires between adders)

    // TODO: XOR each bit of B with M to produce bw
    // (When M=0, bw=B; when M=1, bw=~B)

    // TODO: Instantiate 4 full adders
    // FA0's carry input is M (provides the +1 for two's complement)
    // Each subsequent FA takes the carry from the previous stage

endmodule
