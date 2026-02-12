//============================================================================
// Testbench: Full Adder
//
// YOUR TASK: Complete the 3 sections marked with TODO
//
// A full adder adds three bits (A, B, Cin) and produces Sum and Cout.
//
// Truth Table (fill this in to help you):
//   A B Cin | Sum Cout
//   --------+---------
//   0 0  0  |  ?   ?
//   0 0  1  |  ?   ?
//   0 1  0  |  ?   ?
//   0 1  1  |  ?   ?
//   1 0  0  |  ?   ?
//   1 0  1  |  ?   ?
//   1 1  0  |  ?   ?
//   1 1  1  |  ?   ?
//
// HINT: Study the half adder testbench (tb/halfadder_tb.v) for the pattern.
//============================================================================

`timescale 1ns/1ps

module fulladder_tb;

    //------------------------------------------------------------------------
    // TODO #1: Signal Declarations
    //
    // Declare the input and output signals for the full adder.
    // (refer to halfadder_tb.v for the pattern)
    //------------------------------------------------------------------------
    // YOUR CODE HERE:



    // Expected outputs and error counter (do not modify)
    wire expected_sum;
    wire expected_cout;
    integer error_count;

    //------------------------------------------------------------------------
    // TODO #2: Module Instantiation
    //
    // Instantiate the fulladder module as 'UUT'
    // (refer to halfadder_tb.v for the pattern)
    //------------------------------------------------------------------------
    // YOUR CODE HERE:



    //------------------------------------------------------------------------
    // Expected Output Calculation (do not modify)
    //------------------------------------------------------------------------
    assign expected_sum  = A ^ B ^ Cin;
    assign expected_cout = (A & B) | (B & Cin) | (A & Cin);

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        $display("========================================");
        $display("Full Adder Testbench");
        $display("========================================");
        $display("  A  B Cin | Sum Cout | Expected | Status");
        $display("----------+----------+----------+-------");

        //--------------------------------------------------------------------
        // TODO #3: Test Vectors
        //
        // Apply all 8 input combinations and check each one.
        // (refer to halfadder_tb.v for the pattern)
        //--------------------------------------------------------------------
        // YOUR CODE HERE:



        //--------------------------------------------------------------------
        // Results (do not modify below this line)
        //--------------------------------------------------------------------
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
    // Output Checking Task (do not modify)
    //------------------------------------------------------------------------
    task check_output;
        begin
            if (Sum !== expected_sum || Cout !== expected_cout) begin
                $display("  %b  %b  %b  |  %b    %b  |  %b    %b  | FAIL",
                         A, B, Cin, Sum, Cout, expected_sum, expected_cout);
                error_count = error_count + 1;
            end else begin
                $display("  %b  %b  %b  |  %b    %b  |  %b    %b  | ok",
                         A, B, Cin, Sum, Cout, expected_sum, expected_cout);
            end
        end
    endtask

endmodule
