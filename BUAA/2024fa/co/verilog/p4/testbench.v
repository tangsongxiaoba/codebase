`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   04:55:28 10/29/2024
// Design Name:   mips
// Module Name:   /media/shared/co/verilog/p4/testbench.v
// Project Name:  p4
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module testbench;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the Unit Under Test (UUT)
    mips uut (
        .clk  (clk),
        .reset(reset)
    );

    initial begin
        // Initialize Inputs
        clk   = 0;
        reset = 1;

        // Wait 100 ns for global reset to finish
        #10;
        reset = 0;

        // Add stimulus here

    end

    always #5 clk = ~clk;

endmodule

