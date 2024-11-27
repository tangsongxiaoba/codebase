`include "macro.v"

module mips (
    input wire clk,
    input wire reset,
    input wire [31:0] i_inst_rdata,
    input wire [31:0] m_data_rdata,
    output wire[31:0] i_inst_addr,
    output wire[31:0] m_data_addr,
    output wire[31:0] m_data_wdata,
    output wire[3 :0] m_data_byteen,
    output wire[31:0] m_inst_addr,
    output wire w_grf_we,
    output wire[4:0] w_grf_addr,
    output wire[31:0] w_grf_wdata,
    output wire[31:0] w_inst_addr
);

// determines the Stall signal
hazard _hazard (
    .tUseRs    (tUseRs_D  ),
    .tUseRt    (tUseRt_D  ),
    .tNew_E    (tNew_E    ),
    .tNew_M    (tNew_M    ),
    .rs_D      (rs_D      ),
    .rt_D      (rt_D      ),
    .rs_E      (rs_E      ),
    .rt_E      (rt_E      ),
    .rt_M      (rt_M      ),
    .rIR_E     (rIR_E     ),
    .rIR_M     (rIR_M     ),
    .rIR_W     (rIR_W     ),
    .regWrite_E(regWrite_E),
    .regWrite_M(regWrite_M),
    .regWrite_W(regWrite_W),
    .ismd_D    (ismd_D    ),
    .start_E   (mdOp_E[0] ),
    .busy_E    (busy_E    ),
    .stall     (stall     ),
    .F_mux1_D  (F_mux1_D  ),
    .F_mux2_D  (F_mux2_D  ),
    .F_mux1_E  (F_mux1_E  ),
    .F_mux2_E  (F_mux2_E  ),
    .F_mux1_M  (F_mux1_M  )
);

// Main Datapath
// F
assign npc_F = (npc_D == 0 ? pc_F + 4 : npc_D);

// pc
ffenr #(.INIT(`PC_INIT)) _pc (
    .clk  (clk   ),
    .reset(reset ),
    .en   (~stall),
    .dat  (npc_F ),
    .out  (pc_F  )
);

assign i_inst_addr = pc_F;
assign instr_F     = i_inst_rdata;

// D
// grf actually operates in D and W
grf _grf (
    .clk      (clk       ),
    .reset    (reset     ),
    .readAddr1(rs_D      ),
    .readAddr2(rt_D      ),
    .writeAddr(rIR_W     ),
    .writeData(rID_W     ),
    .readData1(rO1_D     ),
    .readData2(rO2_D     ),
    .regWrite (regWrite_W)
);

mux3 _mux1_D (
    .out(mux_rO1_D),
    .in0(rO1_D    ),
    .in1(rID_W    ),
    .in2(aO_M     ),
    .sel(F_mux1_D )
);

mux3 _mux2_D (
    .out(mux_rO2_D),
    .in0(rO2_D    ),
    .in1(rID_W    ),
    .in2(aO_M     ),
    .sel(F_mux2_D )
);

// delay slot design, forward cmp, has no connection with zero_E
assign zero_D = (mux_rO1_D == mux_rO2_D) ? 1'b1 : 1'b0;
assign ismd_D = (mdOp_D != 0);

npc _npc (
    .pc   (pc_D     ),
    .j26  (j26_D    ),
    .imm  (imm_D    ),
    .rO1  (mux_rO1_D),
    .zero (zero_D   ),
    .npcOp(npcOp_D  ),
    .npc  (npc_D    )
);

// writeRegAddr can be produced at D, and pipeline to E, M, W.
assign rIR_D =
    regDst_D == `REGDST_R ? rd_D :
    regDst_D == `REGDST_LINK ? 5'b11111 :
    rt_D;

// E
mux3 _mux1_E (
    .out(mux_aIA_E),
    .in0(rO1_E    ),
    .in1(rID_W    ),
    .in2(aO_M     ),
    .sel(F_mux1_E )
);

mux3 _mux2_E (
    .out(mux_rO2_E),
    .in0(rO2_E    ),
    .in1(rID_W    ),
    .in2(aO_M     ),
    .sel(F_mux2_E )
);

assign aIB_E = (aluSrc_E == 0 ? mux_rO2_E:
    (extOp_E ? {{16{imm_E[15]}}, imm_E} :
        {16'b0, imm_E}));

alu _alu (
    .aluOp (aluOp_E  ),
    .shamt (shamt_E  ),
    .srcA  (mux_aIA_E),
    .srcB  (aIB_E    ),
    .pc    (pc_E     ),
    .zero  (zero_E   ),
    .aluRes(old_aO_E )
);

hilo _hilo (
    .clk   (clk       ),
    .reset (reset     ),
    .from  (regFrom_E ),
    .start (mdOp_E    ),
    .srcA  (mux_aIA_E ),
    .srcB  (aIB_E     ),
    .isbusy(busy_E    ),
    .result(hilo_res_E)
);

assign aO_E = (regFrom_E == `REGFROM_HILO) ? hilo_res_E : old_aO_E;

// M
mux2 _mux1_M (
    .out(mux_mID_M),
    .in0(rO2_M    ),
    .in1(rID_W    ),
    .sel(F_mux1_M )
);

assign m_inst_addr = pc_M;
assign m_data_addr = aO_M;

assign m_data_wdata =
    memWrite_M == 3 ? mux_mID_M :
    memWrite_M == 2 ? (
        aO_M[1] == 0 ? {{16{1'b0}}, mux_mID_M[15:0]} : {mux_mID_M[15:0], {16{1'b0}}}) :
    memWrite_M == 1 ? (
        aO_M[1:0] == 0 ? {{24{1'b0}}, mux_mID_M[ 7:0]} :
        aO_M[1:0] == 1 ? {{16{1'b0}}, mux_mID_M[ 7:0], {8{1'b0}}} :
        aO_M[1:0] == 2 ? {{8{1'b0}}, mux_mID_M[ 7:0], {16{1'b0}}} :
        {mux_mID_M[ 7:0], {24{1'b0}}}) :
    0;

assign m_data_byteen =
    memWrite_M == 3 ? 4'b1111 :
    memWrite_M == 2 ? (aO_M[1] == 0 ? 4'b0011 : 4'b1100) :
    memWrite_M == 1 ? (
        aO_M[1:0] == 0 ? 4'b0001 :
        aO_M[1:0] == 1 ? 4'b0010 :
        aO_M[1:0] == 2 ? 4'b0100 :
        4'b1000) :
    0;

assign mO_zero_hi_M = {{16{1'b0}}, m_data_rdata[31:16]};
assign mO_zero_lo_M = {{16{1'b0}}, m_data_rdata[15: 0]};
assign mO_sign_hi_M = {{16{m_data_rdata[31]}}, m_data_rdata[31:16]};
assign mO_sign_lo_M = {{16{m_data_rdata[15]}}, m_data_rdata[15: 0]};
assign mO_zero_11_M = {{24{1'b0}}, m_data_rdata[31:24]};
assign mO_zero_10_M = {{24{1'b0}}, m_data_rdata[23:16]};
assign mO_zero_01_M = {{24{1'b0}}, m_data_rdata[15: 8]};
assign mO_zero_00_M = {{24{1'b0}}, m_data_rdata[ 7: 0]};
assign mO_sign_11_M = {{24{m_data_rdata[31]}}, m_data_rdata[31:24]};
assign mO_sign_10_M = {{24{m_data_rdata[23]}}, m_data_rdata[23:16]};
assign mO_sign_01_M = {{24{m_data_rdata[15]}}, m_data_rdata[15: 8]};
assign mO_sign_00_M = {{24{m_data_rdata[ 7]}}, m_data_rdata[ 7: 0]};

assign mO_M =
    loadOp_M == 4 ? (aO_M[1] == 1'b0 ? mO_sign_lo_M : mO_sign_hi_M) : // lh
    loadOp_M == 3 ? (aO_M[1] == 1'b0 ? mO_zero_lo_M : mO_zero_hi_M) : // lhu
    loadOp_M == 2 ? (
        aO_M[1:0] == 3 ? mO_sign_11_M : // lb
        aO_M[1:0] == 2 ? mO_sign_10_M :
        aO_M[1:0] == 1 ? mO_sign_01_M :
        mO_sign_00_M) :
    loadOp_M == 1 ? (
        aO_M[1:0] == 3 ? mO_zero_11_M : // lbu
        aO_M[1:0] == 2 ? mO_zero_10_M :
        aO_M[1:0] == 1 ? mO_zero_01_M :
        mO_zero_00_M) :
    m_data_rdata; // lw

// W
assign rID_W = (regFrom_W == `REGFROM_LOAD) ? mO_W: aO_W;

assign w_grf_we    = regWrite_W;
assign w_grf_addr  = rIR_W;
assign w_grf_wdata = rID_W;
assign w_inst_addr = pc_W;

// Registers
// D
ffenr _r1_D (
    .clk  (clk    ),
    .reset(reset  ),
    .en   (~stall ),
    .dat  (instr_F),
    .out  (instr_D)
);

ffenr _r2_D (
    .clk  (clk   ),
    .reset(reset ),
    .en   (~stall),
    .dat  (pc_F  ),
    .out  (pc_D  )
);

// E
ffrc _r1_E (
    .clk  (clk    ),
    .reset(reset  ),
    .clear(stall  ),
    .dat  (instr_D),
    .out  (instr_E)
);

ffrc _r2_E (
    .clk  (clk  ),
    .reset(reset),
    .clear(stall),
    .dat  (pc_D ),
    .out  (pc_E )
);

ffrc _r3_E (
    .clk  (clk      ),
    .reset(reset    ),
    .clear(stall    ),
    .dat  (mux_rO1_D),
    .out  (rO1_E    )
);

ffrc _r4_E (
    .clk  (clk      ),
    .reset(reset    ),
    .clear(stall    ),
    .dat  (mux_rO2_D),
    .out  (rO2_E    )
);

ffrc #(.WIDTH(5)) _r5_E (
    .clk  (clk  ),
    .reset(reset),
    .clear(stall),
    .dat  (rIR_D),
    .out  (rIR_E)
);

// M
ffr _r1_M (
    .clk  (clk    ),
    .reset(reset  ),
    .dat  (instr_E),
    .out  (instr_M)
);

ffr _r2_M (
    .clk  (clk  ),
    .reset(reset),
    .dat  (pc_E ),
    .out  (pc_M )
);

ffr _r3_M (
    .clk  (clk  ),
    .reset(reset),
    .dat  (aO_E ),
    .out  (aO_M )
);

ffr _r4_M (
    .clk  (clk  ),
    .reset(reset),
    .dat  (rO1_E),
    .out  (rO1_M)
);

ffr _r5_M (
    .clk  (clk      ),
    .reset(reset    ),
    .dat  (mux_rO2_E),
    .out  (rO2_M    )
);

ffr #(.WIDTH(5)) _r6_M (
    .clk  (clk  ),
    .reset(reset),
    .dat  (rIR_E),
    .out  (rIR_M)
);

// W
ffr _r1_W (
    .clk  (clk    ),
    .reset(reset  ),
    .dat  (instr_M),
    .out  (instr_W)
);

ffr _r2_W (
    .clk  (clk  ),
    .reset(reset),
    .dat  (pc_M ),
    .out  (pc_W )
);

ffr _r3_W (
    .clk  (clk  ),
    .reset(reset),
    .dat  (aO_M ),
    .out  (aO_W )
);

ffr _r4_W (
    .clk  (clk  ),
    .reset(reset),
    .dat  (mO_M ),
    .out  (mO_W )
);

ffr #(.WIDTH(5)) _r5_W (
    .clk  (clk  ),
    .reset(reset),
    .dat  (rIR_M),
    .out  (rIR_W)
);

// Wire Definitions
wire        extOp_D   ;
wire        extOp_E   ;
wire        extOp_M   ;
wire        extOp_W   ;
wire        aluSrc_D  ;
wire        aluSrc_E  ;
wire        aluSrc_M  ;
wire        aluSrc_W  ;
wire        regWrite_D;
wire        regWrite_E;
wire        regWrite_M;
wire        regWrite_W;
wire [ 1:0] memWrite_D;
wire [ 1:0] memWrite_E;
wire [ 1:0] memWrite_M;
wire [ 1:0] memWrite_W;
wire [ 1:0] regFrom_D ;
wire [ 1:0] regFrom_E ;
wire [ 1:0] regFrom_M ;
wire [ 1:0] regFrom_W ;
wire [ 1:0] regDst_D  ;
wire [ 1:0] regDst_E  ;
wire [ 1:0] regDst_M  ;
wire [ 1:0] regDst_W  ;
wire [ 2:0] loadOp_D  ;
wire [ 2:0] loadOp_E  ;
wire [ 2:0] loadOp_M  ;
wire [ 2:0] loadOp_W  ;
wire [ 2:0] npcOp_D   ;
wire [ 2:0] npcOp_E   ;
wire [ 2:0] npcOp_M   ;
wire [ 2:0] npcOp_W   ;
wire [ 3:0] mdOp_D    ;
wire [ 3:0] mdOp_E    ;
wire [ 3:0] mdOp_M    ;
wire [ 3:0] mdOp_W    ;
wire [ 3:0] aluOp_D   ;
wire [ 3:0] aluOp_E   ;
wire [ 3:0] aluOp_M   ;
wire [ 3:0] aluOp_W   ;
wire [ 4:0] rs_D      ;
wire [ 4:0] rs_E      ;
wire [ 4:0] rs_M      ;
wire [ 4:0] rs_W      ;
wire [ 4:0] rt_D      ;
wire [ 4:0] rt_E      ;
wire [ 4:0] rt_M      ;
wire [ 4:0] rt_W      ;
wire [ 4:0] rd_D      ;
wire [ 4:0] rd_E      ;
wire [ 4:0] rd_M      ;
wire [ 4:0] rd_W      ;
wire [ 4:0] shamt_D   ;
wire [ 4:0] shamt_E   ;
wire [ 4:0] shamt_M   ;
wire [ 4:0] shamt_W   ;
wire [ 5:0] funct_D   ;
wire [ 5:0] funct_E   ;
wire [ 5:0] funct_M   ;
wire [ 5:0] funct_W   ;
wire [ 5:0] op_D      ;
wire [ 5:0] op_E      ;
wire [ 5:0] op_M      ;
wire [ 5:0] op_W      ;
wire [15:0] imm_D     ;
wire [15:0] imm_E     ;
wire [15:0] imm_M     ;
wire [15:0] imm_W     ;
wire [25:0] j26_D     ;
wire [25:0] j26_E     ;
wire [25:0] j26_M     ;
wire [25:0] j26_W     ;
wire [31:0] pc_F      ;
wire [31:0] pc_D      ;
wire [31:0] pc_E      ;
wire [31:0] pc_M      ;
wire [31:0] pc_W      ;
wire [31:0] instr_F   ;
wire [31:0] instr_D   ;
wire [31:0] instr_E   ;
wire [31:0] instr_M   ;
wire [31:0] instr_W   ;

wire [31:0] mO_zero_hi_M;
wire [31:0] mO_zero_lo_M;
wire [31:0] mO_sign_hi_M;
wire [31:0] mO_sign_lo_M;
wire [31:0] mO_zero_11_M;
wire [31:0] mO_zero_10_M;
wire [31:0] mO_zero_01_M;
wire [31:0] mO_zero_00_M;
wire [31:0] mO_sign_11_M;
wire [31:0] mO_sign_10_M;
wire [31:0] mO_sign_01_M;
wire [31:0] mO_sign_00_M;

wire [31:0] npc_F;

wire        ismd_D;
wire        zero_D;
wire [31:0] rO1_D ;
wire [31:0] rO2_D ;
wire [31:0] npc_D ;

wire        zero_E    ;
wire        busy_E    ;
wire [31:0] rO1_E     ;
wire [31:0] rO2_E     ;
wire [31:0] aIB_E     ;
wire [31:0] aO_E      ;
wire [31:0] old_aO_E  ;
wire [31:0] hilo_res_E;

wire [31:0] aO_M ;
wire [31:0] rO1_M;
wire [31:0] rO2_M;
wire [31:0] mO_M ;

wire [31:0] rID_W;
wire [31:0] aO_W ;
wire [31:0] mO_W ;

wire [31:0] mux_rO1_D;
wire [31:0] mux_rO2_D;
wire [31:0] mux_rO2_E;
wire [31:0] mux_aIA_E;
wire [31:0] mux_aIB_E;
wire [31:0] mux_mID_M;

wire [4:0] rIR_D;
wire [4:0] rIR_E;
wire [4:0] rIR_M;
wire [4:0] rIR_W;

wire       tUseRs_D;
wire       tUseRs_E;
wire       tUseRs_M;
wire       tUseRs_W;
wire [1:0] tUseRt_D;
wire [1:0] tUseRt_E;
wire [1:0] tUseRt_M;
wire [1:0] tUseRt_W;
wire [1:0] tNew_D  ;
wire [1:0] tNew_E  ;
wire [1:0] tNew_M  ;
wire [1:0] tNew_W  ;

wire [1:0] F_mux1_D;
wire [1:0] F_mux2_D;
wire [1:0] F_mux1_E;
wire [1:0] F_mux2_E;
wire       F_mux1_M;
wire       stall   ;

split _split_D (
    .instr(instr_D),
    .rs   (rs_D   ),
    .rt   (rt_D   ),
    .rd   (rd_D   ),
    .shamt(shamt_D),
    .funct(funct_D),
    .op   (op_D   ),
    .imm  (imm_D  ),
    .j26  (j26_D  )
);

split _split_E (
    .instr(instr_E),
    .rs   (rs_E   ),
    .rt   (rt_E   ),
    .rd   (rd_E   ),
    .shamt(shamt_E),
    .funct(funct_E),
    .op   (op_E   ),
    .imm  (imm_E  ),
    .j26  (j26_E  )
);

split _split_M (
    .instr(instr_M),
    .rs   (rs_M   ),
    .rt   (rt_M   ),
    .rd   (rd_M   ),
    .shamt(shamt_M),
    .funct(funct_M),
    .op   (op_M   ),
    .imm  (imm_M  ),
    .j26  (j26_M  )
);

split _split_W (
    .instr(instr_W),
    .rs   (rs_W   ),
    .rt   (rt_W   ),
    .rd   (rd_W   ),
    .shamt(shamt_W),
    .funct(funct_W),
    .op   (op_W   ),
    .imm  (imm_W  ),
    .j26  (j26_W  )
);

ctrl #(`TYPE_D) _ctrl_D (
    .opcode  (op_D      ),
    .funct   (funct_D   ),
    .ext     (extOp_D   ),
    .npcOp   (npcOp_D   ),
    .aluOp   (aluOp_D   ),
    .aluSrc  (aluSrc_D  ),
    .regWrite(regWrite_D),
    .memWrite(memWrite_D),
    .loadOp  (loadOp_D  ),
    .mdOp    (mdOp_D    ),
    .regFrom (regFrom_D ),
    .regDst  (regDst_D  ),
    .tUseRs  (tUseRs_D  ),
    .tUseRt  (tUseRt_D  ),
    .tNew    (tNew_D    )
);

ctrl #(`TYPE_E) _ctrl_E (
    .opcode  (op_E      ),
    .funct   (funct_E   ),
    .ext     (extOp_E   ),
    .npcOp   (npcOp_E   ),
    .aluOp   (aluOp_E   ),
    .aluSrc  (aluSrc_E  ),
    .regWrite(regWrite_E),
    .memWrite(memWrite_E),
    .loadOp  (loadOp_E  ),
    .mdOp    (mdOp_E    ),
    .regFrom (regFrom_E ),
    .regDst  (regDst_E  ),
    .tUseRs  (tUseRs_E  ),
    .tUseRt  (tUseRt_E  ),
    .tNew    (tNew_E    )
);

ctrl #(`TYPE_M) _ctrl_M (
    .opcode  (op_M      ),
    .funct   (funct_M   ),
    .ext     (extOp_M   ),
    .npcOp   (npcOp_M   ),
    .aluOp   (aluOp_M   ),
    .aluSrc  (aluSrc_M  ),
    .regWrite(regWrite_M),
    .memWrite(memWrite_M),
    .loadOp  (loadOp_M  ),
    .mdOp    (mdOp_M    ),
    .regFrom (regFrom_M ),
    .regDst  (regDst_M  ),
    .tUseRs  (tUseRs_M  ),
    .tUseRt  (tUseRt_M  ),
    .tNew    (tNew_M    )
);

ctrl #(`TYPE_W) _ctrl_W (
    .opcode  (op_W      ),
    .funct   (funct_W   ),
    .ext     (extOp_W   ),
    .npcOp   (npcOp_W   ),
    .aluOp   (aluOp_W   ),
    .aluSrc  (aluSrc_W  ),
    .regWrite(regWrite_W),
    .memWrite(memWrite_W),
    .loadOp  (loadOp_W  ),
    .mdOp    (mdOp_W    ),
    .regFrom (regFrom_W ),
    .regDst  (regDst_W  ),
    .tUseRs  (tUseRs_W  ),
    .tUseRt  (tUseRt_W  ),
    .tNew    (tNew_W    )
);

endmodule

// flip-flop with reset
module ffr #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else r <= dat;
        end
        assign out = r;
    endmodule

// flip-flop with reset & clear
module ffrc #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             clear,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (clear) r <= 0;
            else r <= dat;
        end
        assign out = r;
    endmodule

// flip-flop with reset & enable
module ffenr #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             en   ,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (en) r <= dat;
            else r <= r;
        end
        assign out = r;
    endmodule

// // flip-flop with reset & enable & clear
// module ffenrc #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
//     input  wire             clk  ,
//     input  wire             reset,
//     input  wire             en   ,
//     input  wire             clear,
//     input  wire [WIDTH-1:0] dat  ,
//     output wire [WIDTH-1:0] out
// );
//         reg [WIDTH-1:0] r;
//         always @(posedge clk, posedge reset) begin
//             if (reset) r <= INIT;
//             else if (clear) r <= 0;
//             else if (en) r <= dat;
//             else r <= r;
//         end
//         assign out = r;
//     endmodule

module mux2 #(parameter integer WIDTH = 32) (
    input  wire [WIDTH-1:0] in0,
    input  wire [WIDTH-1:0] in1,
    input  wire             sel,
    output wire [WIDTH-1:0] out
);
        assign out = sel ? in1 : in0;
    endmodule

module mux3 #(parameter integer WIDTH = 32) (
    input  wire [WIDTH-1:0] in0,
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [      1:0] sel,
    output wire [WIDTH-1:0] out
);
        assign out = (sel == 0) ? in0 :
            (sel == 1) ? in1 :
            (sel == 2) ? in2 :
            0;
    endmodule
