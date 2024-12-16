`include "macro.v"

module cpu (
    input  wire clk,
    input  wire reset,
    input  wire [ 5:0] HWInt,
    input  wire [31:0] i_inst_rdata,
    input  wire [31:0] m_data_rdata,
    output wire        w_grf_we,
    output wire [ 3:0] m_data_byteen,
    output wire [ 4:0] w_grf_addr,
    output wire [31:0] i_inst_addr,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [31:0] m_inst_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr,
    output wire [31:0] macroscopic_pc
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
    .eret_D    (eret_D    ),
    .mtc0_E    (mtc0_E    ),
    .mtc0_M    (mtc0_M    ),
    .rd_E      (rd_E      ),
    .rd_M      (rd_M      ),
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
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .en   ((~stall) | req),
    .dat  (npc_F         ),
    .out  (old_pc_F      )
);

assign pc_F        = eret_D ? epc : old_pc_F;
assign i_inst_addr = pc_F;
assign instr_F     = exc_AdEL_F ? 0 : i_inst_rdata;

assign exc_AdEL_F = ((|pc_F[1:0]) | (pc_F < `PC_INIT) | (pc_F > `PC_END));
assign exc_code_F = exc_AdEL_F ? `EXC_ADEL : `EXC_NONE;

assign BDIn_F = (npcOp_D != `NPC_DEFAULT);

// D
// grf actually operates in D and W

assign exc_code_D = (
    old_exc_code_D ? old_exc_code_D :
    exc_RI_D ? `EXC_RI :
    syscall_D ? `EXC_SYSCALL :
    old_exc_code_D
);

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
    .req  (req      ),
    .eret (eret_D   ),
    .epc  (epc      ),
    .pc   (pc_D     ),
    .j26  (j26_D    ),
    .imm  (imm_D    ),
    .rO1  (mux_rO1_D),
    .zero (zero_D   ),
    .npcOp(npcOp_D  ),
    .npc  (npc_D    )
);

// writeRegAddr can be produced at D, and pipeline to E, M, W.
assign rIR_D = (
    (regDst_D == `REGDST_R) ? rd_D :
    (regDst_D == `REGDST_LINK) ? 5'b11111 :
    rt_D
);

// E
assign exc_code_E = (
    old_exc_code_E ? old_exc_code_E :
    exc_Ov_E ? `EXC_OV :
    old_exc_code_E
);

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

assign aIB_E = (
    (aluSrc_E == 0) ? mux_rO2_E :
    extOp_E ? {{16{imm_E[15]}}, imm_E} :
    {16'b0, imm_E}
);

alu _alu (
    .aluExcOp(aluExcOp_E),
    .aluOp   (aluOp_E   ),
    .shamt   (shamt_E   ),
    .srcA    (mux_aIA_E ),
    .srcB    (aIB_E     ),
    .pc      (pc_E      ),
    .zero    (zero_E    ),
    .aluRes  (old_aO_E  ),
    .exc_AdEL(exc_AdEL_E),
    .exc_AdES(exc_AdES_E),
    .exc_Ov  (exc_Ov_E  )
);

hilo _hilo (
    .clk   (clk       ),
    .reset (reset     ),
    .req   (req       ),
    .from  (regFrom_E ),
    .start (mdOp_E    ),
    .srcA  (mux_aIA_E ),
    .srcB  (aIB_E     ),
    .isbusy(busy_E    ),
    .result(hilo_res_E)
);

assign aO_E = (regFrom_E == `REGFROM_HILO) ? hilo_res_E : old_aO_E;

// M

assign exc_code_M = (
    old_exc_code_M ? old_exc_code_M :
    exc_AdEL_M ? `EXC_ADEL :
    exc_AdES_M ? `EXC_ADES :
    old_exc_code_M
);

cp0 _cp0 (
    .clk      (clk       ),
    .reset    (reset     ),
    .en       (mtc0_M    ),
    .BDIn     (BDIn_M    ),
    .EXLClr   (eret_M    ),
    .CP0Add   (rd_M      ),
    .ExcCodeIn(exc_code_M),
    .HWInt    (HWInt     ),
    .CP0In    (mux_mID_M ),
    .vpc      (pc_M      ),
    .Req      (req       ),
    .CP0Out   (cO_M      ),
    .EPCOut   (epc       )
);

mux2 _mux1_M (
    .out(mux_mID_M),
    .in0(rO2_M    ),
    .in1(rID_W    ),
    .sel(F_mux1_M )
);

assign m_inst_addr = pc_M;
assign m_data_addr = aO_M;

assign exc_AdES_align_M = (
    ((memWrite_M == `SWORD) && (|aO_M[1:0])) ||
    ((memWrite_M == `SHALF) && (   aO_M[0]))
);

assign exc_AdES_range_M = (memWrite_M != `SNONE) && !(
    (aO_M >= `DM_INIT && aO_M <= `DM_END) ||
    (aO_M >= `TC0_INIT && aO_M <= `TC0_END) ||
    (aO_M >= `TC1_INIT && aO_M <= `TC1_END) ||
    (aO_M >= `IG_INIT && aO_M <= `IG_END)
);

assign exc_AdES_count_M = (memWrite_M != `SNONE) && (
    (aO_M >= 8 + `TC0_INIT && aO_M <= `TC0_END) ||
    (aO_M >= 8 + `TC1_INIT && aO_M <= `TC1_END)
);

assign exc_AdES_TC_M = (
    (memWrite_M == `SHALF || memWrite_M == `SBYTE) &&
    (aO_M >= `TC0_INIT && aO_M <= `TC1_END)
);

assign exc_AdES_Ov_M = (memWrite_M != `SNONE) && old_exc_AdES_M;

assign exc_AdES_M = (
    exc_AdES_align_M |
    exc_AdES_range_M |
    exc_AdES_count_M |
    exc_AdES_TC_M |
    exc_AdES_Ov_M
);

assign m_data_wdata = (
    (req) ? 0 :
    (memWrite_M == `SWORD) ? mux_mID_M :
    (memWrite_M == `SHALF) ? (
        (aO_M[1] == 0) ? {{16{1'b0}}, mux_mID_M[15:0]} : {mux_mID_M[15:0], {16{1'b0}}}) :
    (memWrite_M == `SBYTE) ? (
        (aO_M[1:0] == 0) ? {{24{1'b0}}, mux_mID_M[ 7:0]} :
        (aO_M[1:0] == 1) ? {{16{1'b0}}, mux_mID_M[ 7:0], {8{1'b0}}} :
        (aO_M[1:0] == 2) ? {{8{1'b0}}, mux_mID_M[ 7:0], {16{1'b0}}} :
        {mux_mID_M[ 7:0], {24{1'b0}}}) :
    0
);

assign m_data_byteen = (
    (req) ? 0 :
    (memWrite_M == `SWORD) ? 4'b1111 :
    (memWrite_M == `SHALF) ? ((aO_M[1] == 0) ? 4'b0011 : 4'b1100) :
    (memWrite_M == `SBYTE) ? (
        (aO_M[1:0] == 0) ? 4'b0001 :
        (aO_M[1:0] == 1) ? 4'b0010 :
        (aO_M[1:0] == 2) ? 4'b0100 :
        4'b1000) :
    0
);

assign exc_AdEL_align_M = (
    (loadOp_M == `LWORD && (|aO_M[1:0])) ||
    (loadOp_M == `LHALF && (|aO_M[0]))
);

assign exc_AdEL_TC_M = (
    (loadOp_M == `LHALF || loadOp_M == `LBYTE) &&
    (aO_M >= `TC0_INIT && aO_M <= `TC1_END)
);

assign exc_AdEL_Ov_M = (
    (loadOp_M != `LNONE) && old_exc_AdEL_M
);

assign exc_AdEL_range_M = (
    (loadOp_M != `LNONE) && !(
        (aO_M >= `DM_INIT && aO_M <= `DM_END) ||
        (aO_M >= `TC0_INIT && aO_M <= `TC0_END) ||
        (aO_M >= `TC1_INIT && aO_M <= `TC1_END) ||
        (aO_M >= `IG_INIT && aO_M <= `IG_END)
    )
);

assign exc_AdEL_M = (
    exc_AdEL_align_M |
    exc_AdEL_TC_M |
    exc_AdEL_Ov_M |
    exc_AdEL_range_M
);

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

assign mO_M = (
    (loadOp_M == `LWORD) ? m_data_rdata : // lw
    (loadOp_M == `LHALF) ? ((aO_M[1] == 1'b0) ? mO_sign_lo_M : mO_sign_hi_M) : // lh
    (loadOp_M == `LBYTE) ? (
        (aO_M[1:0] == 3) ? mO_sign_11_M : // lb
        (aO_M[1:0] == 2) ? mO_sign_10_M :
        (aO_M[1:0] == 1) ? mO_sign_01_M :
        mO_sign_00_M) :
    0
);

assign macroscopic_pc = pc_M;

// W
assign rID_W = (
    (regFrom_W == `REGFROM_LOAD) ? mO_W :
    (regFrom_W == `REGFROM_COP0) ? cO_W:
    aO_W
);

assign w_grf_we    = regWrite_W;
assign w_grf_addr  = rIR_W;
assign w_grf_wdata = rID_W;
assign w_inst_addr = pc_W;

// Registers
// D
ffenrc _r1_D (
    .clk  (clk    ),
    .reset(reset  ),
    .en   (~stall ),
    .req  (1'b0   ),
    .clear(req    ),
    .dat  (instr_F),
    .out  (instr_D)
);

ffenr _r2_D (
    .clk  (clk   ),
    .reset(reset ),
    .req  (req   ),
    .en   (~stall),
    .dat  (pc_F  ),
    .out  (pc_D  )
);

ffenrc #(.WIDTH(5)) _r3_D (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(req           ),
    .en   (~stall        ),
    .dat  (exc_code_F    ),
    .out  (old_exc_code_D)
);

ffenrc #(.WIDTH(1)) _r4_D (
    .clk  (clk   ),
    .reset(reset ),
    .req  (1'b0  ),
    .en   (~stall),
    .clear(req   ),
    .dat  (BDIn_F),
    .out  (BDIn_D)
);

// E
ffrc _r1_E (
    .clk  (clk        ),
    .reset(reset      ),
    .req  (1'b0       ),
    .clear(stall | req),
    .dat  (instr_D    ),
    .out  (instr_E    )
);

ffrc _r2_E (
    .clk  (clk  ),
    .reset(reset),
    .clear(1'b0 ),
    .req  (req  ),
    .dat  (pc_D ),
    .out  (pc_E )
);

ffrc _r3_E (
    .clk  (clk        ),
    .reset(reset      ),
    .req  (1'b0       ),
    .clear(stall | req),
    .dat  (mux_rO1_D  ),
    .out  (rO1_E      )
);

ffrc _r4_E (
    .clk  (clk        ),
    .reset(reset      ),
    .req  (1'b0       ),
    .clear(stall | req),
    .dat  (mux_rO2_D  ),
    .out  (rO2_E      )
);

ffrc #(.WIDTH(5)) _r5_E (
    .clk  (clk        ),
    .reset(reset      ),
    .req  (1'b0       ),
    .clear(stall | req),
    .dat  (rIR_D      ),
    .out  (rIR_E      )
);

ffrc #(.WIDTH(5)) _r6_E (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(stall | req   ),
    .dat  (exc_code_D    ),
    .out  (old_exc_code_E)
);

ffrc #(.WIDTH(1)) _r7_E (
    .clk  (clk   ),
    .reset(reset ),
    .req  (1'b0  ),
    .clear(req   ),
    .dat  (BDIn_D),
    .out  (BDIn_E)
);

// M
ffrc _r1_M (
    .clk  (clk    ),
    .reset(reset  ),
    .req  (1'b0   ),
    .clear(req    ),
    .dat  (instr_E),
    .out  (instr_M)
);

ffr _r2_M (
    .clk  (clk  ),
    .reset(reset),
    .req  (req  ),
    .dat  (pc_E ),
    .out  (pc_M )
);

ffrc _r3_M (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (aO_E ),
    .out  (aO_M )
);

ffrc _r4_M (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (rO1_E),
    .out  (rO1_M)
);

ffrc _r5_M (
    .clk  (clk      ),
    .reset(reset    ),
    .req  (1'b0     ),
    .clear(req      ),
    .dat  (mux_rO2_E),
    .out  (rO2_M    )
);

ffrc #(.WIDTH(5)) _r6_M (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (rIR_E),
    .out  (rIR_M)
);

ffrc #(.WIDTH(5)) _r7_M (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(req           ),
    .dat  (exc_code_E    ),
    .out  (old_exc_code_M)
);

ffrc #(.WIDTH(1)) _r8_M (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(req           ),
    .dat  (exc_AdEL_E    ),
    .out  (old_exc_AdEL_M)
);

ffrc #(.WIDTH(1)) _r9_M (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(req           ),
    .dat  (exc_AdES_E    ),
    .out  (old_exc_AdES_M)
);

ffrc #(.WIDTH(1)) _r10_M (
    .clk  (clk   ),
    .reset(reset ),
    .req  (1'b0  ),
    .dat  (BDIn_E),
    .clear(req   ),
    .out  (BDIn_M)
);

// W
ffrc _r1_W (
    .clk  (clk    ),
    .reset(reset  ),
    .req  (1'b0   ),
    .clear(req    ),
    .dat  (instr_M),
    .out  (instr_W)
);

ffr _r2_W (
    .clk  (clk  ),
    .reset(reset),
    .req  (req  ),
    .dat  (pc_M ),
    .out  (pc_W )
);

ffrc _r3_W (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (aO_M ),
    .out  (aO_W )
);

ffrc _r4_W (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (mO_M ),
    .out  (mO_W )
);

ffrc #(.WIDTH(5)) _r5_W (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .clear(req  ),
    .dat  (rIR_M),
    .out  (rIR_W)
);

ffrc #(.WIDTH(5)) _r6_W (
    .clk  (clk           ),
    .reset(reset         ),
    .req  (1'b0          ),
    .clear(req           ),
    .dat  (exc_code_M    ),
    .out  (old_exc_code_W)
);

ffrc _r7_W (
    .clk  (clk  ),
    .reset(reset),
    .req  (1'b0 ),
    .dat  (cO_M ),
    .clear(req  ),
    .out  (cO_W )
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

wire        exc_AdEL_F;
wire [31:0] npc_F     ;
wire [31:0] old_pc_F  ;

wire BDIn_F;
wire BDIn_D;
wire BDIn_E;
wire BDIn_M;

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
wire        exc_AdEL_E;
wire        exc_AdES_E;
wire        exc_Ov_E  ;

wire        req             ;
wire [31:0] epc             ;
wire [31:0] aO_M            ;
wire [31:0] rO1_M           ;
wire [31:0] rO2_M           ;
wire [31:0] mO_M            ;
wire [31:0] cO_M            ;
wire        exc_AdEL_M      ;
wire        exc_AdES_M      ;
wire        old_exc_AdEL_M  ;
wire        old_exc_AdES_M  ;
wire        exc_AdES_align_M;
wire        exc_AdES_range_M;
wire        exc_AdES_count_M;
wire        exc_AdES_TC_M   ;
wire        exc_AdES_Ov_M   ;
wire        exc_AdEL_align_M;
wire        exc_AdEL_range_M;
wire        exc_AdEL_TC_M   ;
wire        exc_AdEL_Ov_M   ;

wire [31:0] rID_W;
wire [31:0] aO_W ;
wire [31:0] mO_W ;
wire [31:0] cO_W ;

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

wire exc_RI_D;
wire exc_RI_E;
wire exc_RI_M;
wire exc_RI_W;

wire [2:0] aluExcOp_D;
wire [2:0] aluExcOp_E;
wire [2:0] aluExcOp_M;
wire [2:0] aluExcOp_W;

wire [4:0] exc_code_F;
wire [4:0] exc_code_D;
wire [4:0] exc_code_E;
wire [4:0] exc_code_M;
wire [4:0] exc_code_W;

wire [4:0] old_exc_code_D;
wire [4:0] old_exc_code_E;
wire [4:0] old_exc_code_M;
wire [4:0] old_exc_code_W;

wire syscall_D;
wire syscall_E;
wire syscall_M;
wire syscall_W;

wire eret_D;
wire eret_E;
wire eret_M;
wire eret_W;

wire mtc0_D;
wire mtc0_E;
wire mtc0_M;
wire mtc0_W;

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
    .rs      (rs_D      ),
    .ext     (extOp_D   ),
    .aluSrc  (aluSrc_D  ),
    .memWrite(memWrite_D),
    .regWrite(regWrite_D),
    .regDst  (regDst_D  ),
    .regFrom (regFrom_D ),
    .loadOp  (loadOp_D  ),
    .mdOp    (mdOp_D    ),
    .npcOp   (npcOp_D   ),
    .aluOp   (aluOp_D   ),
    .tUseRs  (tUseRs_D  ),
    .tUseRt  (tUseRt_D  ),
    .tNew    (tNew_D    ),
    .exc_RI  (exc_RI_D  ),
    .aluExcOp(aluExcOp_D),
    .syscall (syscall_D ),
    .eret    (eret_D    ),
    .mtc0    (mtc0_D    )
);

ctrl #(`TYPE_E) _ctrl_E (
    .opcode  (op_E      ),
    .funct   (funct_E   ),
    .rs      (rs_E      ),
    .ext     (extOp_E   ),
    .aluSrc  (aluSrc_E  ),
    .memWrite(memWrite_E),
    .regWrite(regWrite_E),
    .regDst  (regDst_E  ),
    .regFrom (regFrom_E ),
    .loadOp  (loadOp_E  ),
    .mdOp    (mdOp_E    ),
    .npcOp   (npcOp_E   ),
    .aluOp   (aluOp_E   ),
    .tUseRs  (tUseRs_E  ),
    .tUseRt  (tUseRt_E  ),
    .tNew    (tNew_E    ),
    .exc_RI  (exc_RI_E  ),
    .aluExcOp(aluExcOp_E),
    .syscall (syscall_E ),
    .eret    (eret_E    ),
    .mtc0    (mtc0_E    )
);

ctrl #(`TYPE_M) _ctrl_M (
    .opcode  (op_M      ),
    .funct   (funct_M   ),
    .rs      (rs_M      ),
    .ext     (extOp_M   ),
    .aluSrc  (aluSrc_M  ),
    .memWrite(memWrite_M),
    .regWrite(regWrite_M),
    .regDst  (regDst_M  ),
    .regFrom (regFrom_M ),
    .loadOp  (loadOp_M  ),
    .mdOp    (mdOp_M    ),
    .npcOp   (npcOp_M   ),
    .aluOp   (aluOp_M   ),
    .tUseRs  (tUseRs_M  ),
    .tUseRt  (tUseRt_M  ),
    .tNew    (tNew_M    ),
    .exc_RI  (exc_RI_M  ),
    .aluExcOp(aluExcOp_M),
    .syscall (syscall_M ),
    .eret    (eret_M    ),
    .mtc0    (mtc0_M    )
);

ctrl #(`TYPE_W) _ctrl_W (
    .opcode  (op_W      ),
    .funct   (funct_W   ),
    .rs      (rs_W      ),
    .ext     (extOp_W   ),
    .aluSrc  (aluSrc_W  ),
    .memWrite(memWrite_W),
    .regWrite(regWrite_W),
    .regDst  (regDst_W  ),
    .regFrom (regFrom_W ),
    .loadOp  (loadOp_W  ),
    .mdOp    (mdOp_W    ),
    .npcOp   (npcOp_W   ),
    .aluOp   (aluOp_W   ),
    .tUseRs  (tUseRs_W  ),
    .tUseRt  (tUseRt_W  ),
    .tNew    (tNew_W    ),
    .exc_RI  (exc_RI_W  ),
    .aluExcOp(aluExcOp_W),
    .syscall (syscall_W ),
    .eret    (eret_W    ),
    .mtc0    (mtc0_W    )
);

endmodule

// flip-flop with reset & req
module ffr #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             req  ,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (req) r <= `EXC_INIT;
            else r <= dat;
        end
        assign out = r;
    endmodule

// flip-flop with reset & clear & req
module ffrc #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             req  ,
    input  wire             clear,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (req) r <= `EXC_INIT;
            else if (clear) r <= 0;
            else r <= dat;
        end
        assign out = r;
    endmodule

// flip-flop with reset & enable & req
module ffenr #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             req  ,
    input  wire             en   ,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (req) r <= `EXC_INIT;
            else if (en) r <= dat;
            else r <= r;
        end
        assign out = r;
    endmodule

// flip-flop with reset & enable & clear & req
module ffenrc #(parameter integer WIDTH = 32, parameter integer INIT = 0) (
    input  wire             clk  ,
    input  wire             reset,
    input  wire             req  ,
    input  wire             en   ,
    input  wire             clear,
    input  wire [WIDTH-1:0] dat  ,
    output wire [WIDTH-1:0] out
);
        reg [WIDTH-1:0] r;
        always @(posedge clk, posedge reset) begin
            if (reset) r <= INIT;
            else if (req) r <= `EXC_INIT;
            else if (clear) r <= 0;
            else if (en) r <= dat;
            else r <= r;
        end
        assign out = r;
    endmodule

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
