`include "macro.v"

module mips (
    input  wire        clk,
    input  wire        reset,
    input  wire        interrupt,
    input  wire [31:0] i_inst_rdata,
    input  wire [31:0] m_data_rdata,
    output wire        w_grf_we,
    output wire [3 :0] m_data_byteen,
    output wire [3 :0] m_int_byteen,
    output wire [4 :0] w_grf_addr,
    output wire [31:0] m_int_addr,
    output wire [31:0] i_inst_addr,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [31:0] m_inst_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr,
    output wire [31:0] macroscopic_pc
);

assign m_data_addr   = bridge_m_data_addr;
assign m_data_byteen = bridge_m_data_byteen;
assign m_int_addr    = bridge_m_data_addr;
assign m_int_byteen  = bridge_m_data_byteen;

wire [5:0] HWInt = {3'b0, interrupt, tc1_irq, tc0_irq};

wire [31:0] tmp_m_data_wdata    ;
wire [31:0] tmp_m_data_addr     ;
wire [31:0] tmp_m_data_rdata    ;
wire [31:0] bridge_m_data_addr  ;
wire [31:0] tc0_addr            ;
wire [31:0] tc0_din             ;
wire [31:0] tc0_dout            ;
wire [31:0] tc1_addr            ;
wire [31:0] tc1_din             ;
wire [31:0] tc1_dout            ;
wire [ 3:0] tmp_m_data_byteen   ;
wire [ 3:0] bridge_m_data_byteen;
wire        tc0_we              ;
wire        tc1_we              ;
wire        tc0_irq;
wire        tc1_irq             ;

cpu _cpu (
    .clk           (clk              ),
    .reset         (reset            ),
    .HWInt         (HWInt            ),
    .i_inst_rdata  (i_inst_rdata     ),
    .m_data_rdata  (tmp_m_data_rdata ),
    .w_grf_we      (w_grf_we         ),
    .m_data_byteen (tmp_m_data_byteen),
    .w_grf_addr    (w_grf_addr       ),
    .i_inst_addr   (i_inst_addr      ),
    .m_data_addr   (tmp_m_data_addr  ),
    .m_data_wdata  (tmp_m_data_wdata ),
    .m_inst_addr   (m_inst_addr      ),
    .w_grf_wdata   (w_grf_wdata      ),
    .w_inst_addr   (w_inst_addr      ),
    .macroscopic_pc(macroscopic_pc   )
);

bridge _bridge (
    .m_data_addr      (bridge_m_data_addr  ),
    .m_data_wdata     (m_data_wdata        ),
    .m_data_byteen    (bridge_m_data_byteen),
    .m_data_rdata     (m_data_rdata        ),
    .tmp_m_data_addr  (tmp_m_data_addr     ),
    .tmp_m_data_wdata (tmp_m_data_wdata    ),
    .tmp_m_data_byteen(tmp_m_data_byteen   ),
    .tmp_m_data_rdata (tmp_m_data_rdata    ),
    .tc0_addr         (tc0_addr            ),
    .tc0_we           (tc0_we              ),
    .tc0_din          (tc0_din             ),
    .tc0_dout         (tc0_dout            ),
    .tc1_addr         (tc1_addr            ),
    .tc1_we           (tc1_we              ),
    .tc1_din          (tc1_din             ),
    .tc1_dout         (tc1_dout            )
);

TC _tc0 (
    .clk  (clk           ),
    .reset(reset         ),
    .Addr (tc0_addr[31:2]),
    .WE   (tc0_we        ),
    .Din  (tc0_din       ),
    .Dout (tc0_dout      ),
    .IRQ  (tc0_irq       )
);

TC _tc1 (
    .clk  (clk           ),
    .reset(reset         ),
    .Addr (tc1_addr[31:2]),
    .WE   (tc1_we        ),
    .Din  (tc1_din       ),
    .Dout (tc1_dout      ),
    .IRQ  (tc1_irq       )
);

endmodule
