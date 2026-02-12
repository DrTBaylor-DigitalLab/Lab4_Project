// fulladder.v - Full Adder Module
// Lab 4: Hierarchical Design - Built from Half Adders
//
// A full adder adds two bits plus a carry-in and produces sum and carry-out
//
// Truth Table:
//   A | B | Cin | Sum | Cout
//   0 | 0 |  0  |  0  |  0
//   0 | 0 |  1  |  1  |  0
//   0 | 1 |  0  |  1  |  0
//   0 | 1 |  1  |  0  |  1
//   1 | 0 |  0  |  1  |  0
//   1 | 0 |  1  |  0  |  1
//   1 | 1 |  0  |  0  |  1
//   1 | 1 |  1  |  1  |  1
//
// Implementation using two half adders:
//   First half adder: adds A and B
//   Second half adder: adds result with Cin
//   Carry out is OR of both carry outputs

module fulladder(
    input  A,        // First input bit
    input  B,        // Second input bit
    input  Cin,      // Carry input from previous stage
    output Sum,      // Sum output
    output Cout      // Carry output to next stage
);

    // TODO: Declare internal wires for connecting half adders

    // TODO: Instantiate first half adder (adds A and B)

    // TODO: Instantiate second half adder (adds first sum with Cin)

    // TODO: Generate final carry output (OR of both carries)

endmodule
