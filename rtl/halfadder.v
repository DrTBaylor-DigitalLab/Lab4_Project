// halfadder.v - Half Adder Module
// Lab 4: Hierarchical Design - Building Block for Full Adder
//
// A half adder adds two single bits and produces a sum and carry output
//
// Truth Table:
//   A | B | Sum | Carry
//   0 | 0 |  0  |   0
//   0 | 1 |  1  |   0
//   1 | 0 |  1  |   0
//   1 | 1 |  0  |   1
//
// Logic Equations:
//   Sum = A XOR B
//   Carry = A AND B

module halfadder(
    input  A,        // First input bit
    input  B,        // Second input bit
    output Sum,      // Sum output (A XOR B)
    output Carry     // Carry output (A AND B)
);

    // TODO: Implement half adder logic
    // Hint: Use assign statements with XOR and AND operations

endmodule
