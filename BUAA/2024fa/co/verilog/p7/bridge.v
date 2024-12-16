`include "macro.v"

module bridge (
    output wire [31:0] m_data_addr      ,
    output wire [31:0] m_data_wdata     ,
    output wire [ 3:0] m_data_byteen    ,
    input  wire [31:0] m_data_rdata     ,
    input  wire [31:0] tmp_m_data_addr  ,
    input  wire [31:0] tmp_m_data_wdata ,
    input  wire [ 3:0] tmp_m_data_byteen,
    output wire [31:0] tmp_m_data_rdata ,
    output wire [31:0] tc0_addr         ,
    output wire        tc0_we           ,
    output wire [31:0] tc0_din          ,
    input  wire [31:0] tc0_dout         ,
    output wire [31:0] tc1_addr         ,
    output wire        tc1_we           ,
    output wire [31:0] tc1_din          ,
    input  wire [31:0] tc1_dout
);

assign m_data_addr = tmp_m_data_addr;
assign tc0_addr    = tmp_m_data_addr;
assign tc1_addr    = tmp_m_data_addr;

assign tc0_din      = tmp_m_data_wdata;
assign tc1_din      = tmp_m_data_wdata;
assign m_data_wdata = tmp_m_data_wdata;

wire tc0 = (tmp_m_data_addr >= `TC0_INIT) && (tmp_m_data_addr <= `TC0_END);
wire tc1 = (tmp_m_data_addr >= `TC1_INIT) && (tmp_m_data_addr <= `TC1_END);

wire we = (|tmp_m_data_byteen);

assign tc0_we        = we && tc0;
assign tc1_we        = we && tc1;
assign m_data_byteen = (tc0 | tc1) ? 0 : tmp_m_data_byteen;

assign tmp_m_data_rdata = (
    (tc0) ? tc0_dout :
    (tc1) ? tc1_dout :
    m_data_rdata
);

endmodule //bridge
