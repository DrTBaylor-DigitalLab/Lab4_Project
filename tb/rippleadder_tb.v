//============================================================================
// Testbench: 4-bit Ripple Carry Adder/Subtractor
//
// Self-checking testbench provided to students.
// Tests addition and subtraction cases including overflow and borrow.
//============================================================================

`timescale 1ns/1ps

module rippleadder_tb;

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  [3:0] A, B;         // 4-bit inputs
    reg        M;            // Mode: 0 = add, 1 = subtract
    wire [3:0] Sum;          // 4-bit result
    wire       Cout;         // Carry out

    // Golden model: mirrors the hardware (XOR B with M, then add with M as carry-in)
    wire [3:0] bw;
    wire [4:0] expected;
    assign bw = B ^ {4{M}};
    assign expected = A + bw + M;

    // Error tracking
    integer error_count;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    rippleadder UUT (
        .A(A),
        .B(B),
        .M(M),
        .Sum(Sum),
        .Cout(Cout)
    );

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        $display("================================================");
        $display("4-bit Adder/Subtractor Testbench");
        $display("================================================");

        // --- Addition tests (M=0) ---
        $display("--- Addition (M=0) ---");
        $display("   A  +  B  = Cout Sum | Expected | Status");
        $display("--------+------+-------+----------+-------");

        M = 0;

        A = 4'd0;  B = 4'd0;  #10; check_output();  // 0 + 0 = 0
        A = 4'd3;  B = 4'd2;  #10; check_output();  // 3 + 2 = 5
        A = 4'd5;  B = 4'd7;  #10; check_output();  // 5 + 7 = 12
        A = 4'd7;  B = 4'd8;  #10; check_output();  // 7 + 8 = 15
        A = 4'd15; B = 4'd1;  #10; check_output();  // 15 + 1 = 16 (overflow)
        A = 4'd15; B = 4'd15; #10; check_output();  // 15 + 15 = 30 (overflow)

        // --- Subtraction tests (M=1) ---
        $display("--- Subtraction (M=1) ---");
        $display("   A  -  B  = Cout Sum | Expected | Status");
        $display("--------+------+-------+----------+-------");

        M = 1;

        A = 4'd5;  B = 4'd3;  #10; check_output();  // 5 - 3 = 2
        A = 4'd7;  B = 4'd7;  #10; check_output();  // 7 - 7 = 0
        A = 4'd15; B = 4'd1;  #10; check_output();  // 15 - 1 = 14
        A = 4'd8;  B = 4'd3;  #10; check_output();  // 8 - 3 = 5
        A = 4'd0;  B = 4'd1;  #10; check_output();  // 0 - 1 = -1 (borrow)
        A = 4'd3;  B = 4'd8;  #10; check_output();  // 3 - 8 = -5 (borrow)

        // Results
        $display("================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All outputs correct!");
        end else begin
            $display("TEST FAILED - %0d errors found", error_count);
        end
        $display("================================================");

        if (error_count == 0)
            $finish(0);
        else
            $finish(1);
    end

    //------------------------------------------------------------------------
    // Output Checking Task
    //------------------------------------------------------------------------
    task check_output;
        begin
            if ({Cout, Sum} !== expected) begin
                $display("  %2d  %s %2d  =  %b   %4b |  %b  %4b  | FAIL",
                         A, M ? "-" : "+", B, Cout, Sum, expected[4], expected[3:0]);
                error_count = error_count + 1;
            end else begin
                $display("  %2d  %s %2d  =  %b   %4b |  %b  %4b  | ok",
                         A, M ? "-" : "+", B, Cout, Sum, expected[4], expected[3:0]);
            end
        end
    endtask

endmodule
