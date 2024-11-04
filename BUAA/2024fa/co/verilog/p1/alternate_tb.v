`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:01:54 10/14/2024
// Design Name:   alternate
// Module Name:   /media/shared/co/verilog/P1/alternate_tb.v
// Project Name:  P1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alternate
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alternate_tb;

	// Inputs
	reg clk;
	reg rst_n;
	reg number;

	// Outputs
	wire check;

	// Instantiate the Unit Under Test (UUT)
	alternate uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.number(number), 
		.check(check)
	);

	integer i,j;
	reg [31:0] num[2:0];

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 1;
		num[0] = 32'b00011110110011000000000000000000;
		num[1] = 32'b11100001001100111111111111111111;
		num[2] = 32'b10011100001111100000011111110000;
		// number = 0;

		// Wait 100 ns for global reset to finish
		for(j = 0; j < 3; j = j + 1) begin
			#5;
			rst_n = 0;
			#5;
			rst_n = 1;
			for(i = 31; i >= 0; i = i - 1) begin
				number = num[j][i];
				#10;
			end
		end
		
		// Add stimulus here

	end

	always #5 clk = ~clk;
      
endmodule

