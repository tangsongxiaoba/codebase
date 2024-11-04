`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:59 10/14/2024 
// Design Name: 
// Module Name:    test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module test(
    input [7:0] in,
    output reg [2:0] pos );
    
    casez (in)
        8'bzzzzzzz1: pos = 0;
        8'bzzzzzz10: pos = 1;
        8'bzzzzz100: pos = 2;
        8'bzzzz1000: pos = 3;
        8'bzzz10000: pos = 4;
        8'bzz100000: pos = 5;
        8'bz1000000: pos = 6;
        8'b10000000: pos = 7;
        default: pos = 0;
    endcase

endmodule
