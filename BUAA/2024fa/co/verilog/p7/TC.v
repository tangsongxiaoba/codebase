`timescale 1ns / 1ps
`define IDLE 2'b00
`define LOAD 2'b01
`define CNT  2'b10
`define INT  2'b11

`define CTRL   mem[0]
`define PRESET mem[1]
`define COUNT  mem[2]

module TC (
    input  wire        clk  ,
    input  wire        reset,
    input  wire [31:2] Addr ,
    input  wire        WE   ,
    input  wire [31:0] Din  ,
    output wire [31:0] Dout ,
    output wire        IRQ
);

    reg [ 1:0] state     ;
    reg [31:0] mem  [2:0];

    reg _IRQ;
    assign IRQ = `CTRL[3] & _IRQ;

    assign Dout = mem[Addr[3:2]];

    wire [31:0] load = Addr[3:2] == 0 ? {28'h0, Din[3:0]} : Din;

    integer i;
    always @(posedge clk) begin
        if(reset) begin
            state <= 0;
            for(i = 0; i < 3; i = i+1) mem[i] <= 0;
            _IRQ  <= 0;
        end
        else if(WE) begin
            // $display("%d@: *%h <= %h", $time, {Addr, 2'b00}, load);
            mem[Addr[3:2]] <= load;
        end
        else begin
            case(state)
                `IDLE : if(`CTRL[0]) begin
                    state <= `LOAD;
                    _IRQ  <= 1'b0;
                end
                `LOAD : begin
                    `COUNT <= `PRESET;
                    state  <= `CNT;
                end
                `CNT :
                if(`CTRL[0]) begin
                    if(`COUNT > 1) `COUNT <= `COUNT-1;
                    else begin
                        `COUNT <= 0;
                        state  <= `INT;
                        _IRQ   <= 1'b1;
                    end
                end
                else state <= `IDLE;
                default : begin
                    if(`CTRL[2:1] == 2'b00) `CTRL[0] <= 1'b0;
                    else _IRQ <= 1'b0;
                    state <= `IDLE;
                end
            endcase
        end
    end

endmodule
