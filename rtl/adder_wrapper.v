module adder_wrapper(
    input [15:0] sw,
    output [15:0] led
    );

    // Internal signals
    wire [3:0] A, B;
    wire [3:0] Sum;
    wire       Cout;
    wire       M;

    // Extract inputs from switches
    assign A = sw[3:0];     // First 4-bit number
    assign B = sw[7:4];     // Second 4-bit number
    assign M = sw[15];      // Mode: 0 = add, 1 = subtract

    // Mirror lower 8 switches to lower 8 LEDs for input validation
    assign led[7:0] = sw[7:0];

    // Show mode on LED 8
    assign led[8] = M;

    // Unused LEDs off
    assign led[10:9] = 2'b00;

    // Connect the adder's outputs to the upper LEDs
    assign led[14:11] = Sum;
    assign led[15]    = Cout;

    // TODO: Instantiate your 4-bit rippleadder module here.

endmodule
