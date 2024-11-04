`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:19:08 10/13/2024
// Design Name:   expr
// Module Name:   /media/shared/co/verilog/P1/expr_tb.v
// Project Name:  P1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: expr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module expr_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	expr uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in = "1";
		#10;
		in = "+";
		#10;
		in = "2";
		#10;
		in = "*";
		#10;
		in = "3";
		#20;
		clr = 1;
		#10;
		in = "1";
		#10;
		in = "+";
		#10;
		in = "2";
		#10;
		in = "*";
		#10;
		in = "3";
		#10;


	end

	always #10 clk = ~clk;

      
endmodule

