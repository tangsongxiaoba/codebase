`include "macro.v"

module hazard (
    input  wire       tUseRs,
    input  wire [1:0] tUseRt,
    input  wire [1:0] tNew_E,
    input  wire [1:0] tNew_M,
    input  wire [4:0] rs_D,
    input  wire [4:0] rt_D,
    input  wire [4:0] rs_E,
    input  wire [4:0] rt_E,
    input  wire [4:0] rt_M,
    input  wire [4:0] rIR_E,
    input  wire [4:0] rIR_M,
    input  wire [4:0] rIR_W,
    input  wire       regWrite_E,
    input  wire       regWrite_M,
    input  wire       regWrite_W,
    output wire       stall,
    output wire [1:0] F_mux1_D,
    output wire [1:0] F_mux2_D,
    output wire [1:0] F_mux1_E,
    output wire [1:0] F_mux2_E,
    output wire       F_mux1_M
);

// Stall
wire stall_rs0_E1 = (tUseRs === 0) & (tNew_E === 1) & // T
    (rs_D === rIR_E) & regWrite_E;                   // A
wire stall_rs0_E2 = (tUseRs === 0) & (tNew_E === 2) &
    (rs_D === rIR_E) & regWrite_E;
wire stall_rs1_E2 = (tUseRs === 1) & (tNew_E === 2) &
    (rs_D === rIR_E) & regWrite_E;
wire stall_rs0_M1 = (tUseRs === 0) & (tNew_M === 1) &
    (rs_D === rIR_M) & regWrite_M;

wire stall_rt0_E1 = (tUseRt === 0) & (tNew_E === 1) & // T
    (rt_D === rIR_E) & regWrite_E;                   // A
wire stall_rt0_E2 = (tUseRt === 0) & (tNew_E === 2) &
    (rt_D === rIR_E) & regWrite_E;
wire stall_rt1_E2 = (tUseRt === 1) & (tNew_E === 2) &
    (rt_D === rIR_E) & regWrite_E;
wire stall_rt0_M1 = (tUseRt === 0) & (tNew_M === 1) &
    (rt_D === rIR_M) & regWrite_M;

wire stall_rs = stall_rs0_E1 | stall_rs0_E2 | stall_rs0_M1 | stall_rs1_E2;
wire stall_rt = stall_rt0_E1 | stall_rt0_E2 | stall_rt0_M1 | stall_rt1_E2;

assign stall = stall_rs | stall_rt;

// Forwarding
assign F_mux1_D = ((rs_D !== 0) & (rs_D === rIR_M) & regWrite_M) ? 2 :
    ((rs_D !== 0) & (rs_D === rIR_W) & regWrite_W) ? 1 :
    0;
assign F_mux2_D = ((rt_D !== 0) & (rt_D === rIR_M) & regWrite_M) ? 2 :
    ((rt_D !== 0) & (rt_D === rIR_W) & regWrite_W) ? 1 :
    0;
assign F_mux1_E = ((rs_E !== 0) & (rs_E === rIR_M) & regWrite_M) ? 2 :
    ((rs_E !== 0) & (rs_E === rIR_W) & regWrite_W) ? 1 :
    0;
assign F_mux2_E = ((rt_E !== 0) & (rt_E === rIR_M) & regWrite_M) ? 2 :
    ((rt_E !== 0) & (rt_E === rIR_W) & regWrite_W) ? 1 :
    0;
assign F_mux1_M = ((rt_M !== 0) & (rt_M === rIR_W) & regWrite_W) ? 1 :
    0;

endmodule
