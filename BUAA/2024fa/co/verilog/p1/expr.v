`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:32 10/13/2024 
// Design Name: 
// Module Name:    expr 
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
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

    parameter A = 0, B = 1, C = 2;
    reg [1:0] state, next_state;
    reg type;

    always @(*) begin
        if (in >= "0" && in <= "9") type = 1;
        else type = 0;
        case (state)
            A: next_state = type ? B : C; 
            B: next_state = type ? C : A; 
            C: next_state = C; 
        endcase
    end

    always @(posedge clk, posedge clr) begin
        if(clr) state <= A;
        else state <= next_state;
    end

    assign out = (state == B);

endmodule
