//============================================================================
// Testbench: Half Adder
//
// Self-checking testbench that verifies all 4 input combinations.
// Provided to students - use this as a reference for writing fulladder_tb.v
//============================================================================

`timescale 1ns/1ps

module halfadder_tb;

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  A, B;           // Inputs (testbench drives these)
    wire Sum, Carry;     // Outputs (testbench observes these)
    wire expected_sum;   // What Sum should be
    wire expected_carry; // What Carry should be

    // Error tracking
    integer error_count;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    halfadder UUT (
        .A(A),
        .B(B),
        .Sum(Sum),
        .Carry(Carry)
    );

    //------------------------------------------------------------------------
    // Expected Output Calculation (golden model)
    //------------------------------------------------------------------------
    assign expected_sum   = A ^ B;
    assign expected_carry = A & B;

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        $display("========================================");
        $display("Half Adder Testbench");
        $display("========================================");
        $display("  A  B | Sum Carry | Expected | Status");
        $display("-------+----------+----------+-------");

        // Test all 4 input combinations
        {A, B} = 2'b00; #10; check_output();
        {A, B} = 2'b01; #10; check_output();
        {A, B} = 2'b10; #10; check_output();
        {A, B} = 2'b11; #10; check_output();

        // Results
        $display("========================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All outputs correct!");
        end else begin
            $display("TEST FAILED - %0d errors found", error_count);
        end
        $display("========================================");

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
            if (Sum !== expected_sum || Carry !== expected_carry) begin
                $display("  %b  %b |  %b    %b   |  %b    %b   | FAIL",
                         A, B, Sum, Carry, expected_sum, expected_carry);
                error_count = error_count + 1;
            end else begin
                $display("  %b  %b |  %b    %b   |  %b    %b   | ok",
                         A, B, Sum, Carry, expected_sum, expected_carry);
            end
        end
    endtask

endmodule
