`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:40:45 10/14/2024 
// Design Name: 
// Module Name:    alternate 
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
module alternate(
    input clk,
    input rst_n,
    input number,
    output check
    );

    reg [2:0] st;
    reg flag;
    reg w;

    always @(posedge clk, negedge rst_n) begin
        if(rst_n && flag == 0) begin
            w <= number;
        end 
        else if(~rst_n) begin
            st <= 0;
            flag <= 0;
        end
        else begin
            case (st)
                0: st <= number === w ? 1 : 2;
                1: st <= number === w ? 0 : 5;
                2: st <= number === w ? 3 : 4;
                3: st <= 3;
                4: st <= number === w ? 6 : 2;
                5: st <= number === w ? 6 : 1;
                6: st <= number === w ? 7 : 2;
                7: st <= number === w ? 6 : 3;
            endcase
        end
    end

    always @(posedge clk) begin
        if(flag == 0) flag <= flag + 1;
        
    end

    assign check = (st == 4 || st == 5 || st == 6);


endmodule
