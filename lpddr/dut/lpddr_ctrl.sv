`include "define.svh"

module lpddr_ctrl (
    // APB interface ===========================
    input                            pclk,
    input                            presetn,
    input  [`APB_ADDR_WIDTH - 1:0]   paddr,
    input  [`APB_DATA_WIDTH - 1:0]   pwdata,
    input                            pwrite,
    input                            psel,
    input                            penable,
    output                           pready,
    output [`APB_DATA_WIDTH - 1:0]   prdata,

    // AXI interface ===========================
    input                            aclk,
    input                            aresetn,

    // Write address channel
    input  [`AXI_ID_WIDTH - 1:0]     awid,
    input  [`AXI_ADDR_WIDTH - 1:0]   awaddr,
    input  [`AXI_LEN_WIDTH - 1:0]    awlen,
    input  [`AXI_SIZE_WIDTH - 1:0]   awsize,
    input  [`AXI_BURST_WIDTH - 1:0]  awburst,
    input                            awlock,
    input  [`AXI_CACHE_WIDTH - 1:0]  awcache,
    input  [`AXI_PROT_WIDTH - 1:0]   awprot,
    input                            awvalid,
    output                           awready,

    // Write data channel
    input  [`AXI_DATA_WIDTH - 1:0]   wdata,
    input  [`AXI_STRB_WIDTH - 1:0]   wstrb,
    input                            wlast,
    input                            wvalid,
    output                           wready,

    // Write response channel
    output [`AXI_ID_WIDTH - 1:0]     bid,
    output [`AXI_RESP_WIDTH - 1:0]   bresp,
    output                           bvalid,
    input                            bready,

    // Read address channel
    input  [`AXI_ID_WIDTH - 1:0]     arid,
    input  [`AXI_ADDR_WIDTH - 1:0]   araddr,
    input  [`AXI_LEN_WIDTH - 1:0]    arlen,
    input  [`AXI_SIZE_WIDTH - 1:0]   arsize,
    input  [`AXI_BURST_WIDTH - 1:0]  arburst,
    input                            arlock,
    input  [`AXI_CACHE_WIDTH - 1:0]  arcache,
    input  [`AXI_PROT_WIDTH - 1:0]   arprot,
    input                            arvalid,
    output                           arready,

    // Read data channel
    output [`AXI_ID_WIDTH - 1:0]     rid,
    output [`AXI_DATA_WIDTH - 1:0]   rdata,
    output [`AXI_BURST_WIDTH - 1:0]  rresp,
    output                           rlast,
    output                           rvalid,
    input                            rready

);

// ============================================================
reg [`APB_DATA_WIDTH - 1:0] mem [`APB_ADDR_WIDTH - 1:0];

assign pready = 1'b1;
assign prdata = mem[paddr];

always_ff @(posedge pclk) begin
    if (pwrite & psel & penable) begin
        mem[paddr] <= pwdata;
    end
end

// ============================================================
axi_ram #(
    .DATA_WIDTH         ( `AXI_DATA_WIDTH   ),
    .ADDR_WIDTH         ( `AXI_ADDR_WIDTH   ),
    .STRB_WIDTH         ( `AXI_STRB_WIDTH   ),
    .ID_WIDTH           ( `AXI_ID_WIDTH     ),
    .PIPELINE_OUTPUT    ( 0                 )
)u_axi_ram(
    .clk                ( aclk              ),
    .rst                ( aresetn           ),
    .s_axi_awid         ( awid              ),
    .s_axi_awaddr       ( awaddr            ),
    .s_axi_awlen        ( awlen             ),
    .s_axi_awsize       ( awsize            ),
    .s_axi_awburst      ( awburst           ),
    .s_axi_awlock       ( awlock            ),
    .s_axi_awcache      ( awcache           ),
    .s_axi_awprot       ( awprot            ),
    .s_axi_awvalid      ( awvalid           ),
    .s_axi_awready      ( awready           ),
    .s_axi_wdata        ( wdata             ),
    .s_axi_wstrb        ( wstrb             ),
    .s_axi_wlast        ( wlast             ),
    .s_axi_wvalid       ( wvalid            ),
    .s_axi_wready       ( wready            ),
    .s_axi_bid          ( bid               ),
    .s_axi_bresp        ( bresp             ),
    .s_axi_bvalid       ( bvalid            ),
    .s_axi_bready       ( bready            ),
    .s_axi_arid         ( arid              ),
    .s_axi_araddr       ( araddr            ),
    .s_axi_arlen        ( arlen             ),
    .s_axi_arsize       ( arsize            ),
    .s_axi_arburst      ( arburst           ),
    .s_axi_arlock       ( arlock            ),
    .s_axi_arcache      ( arcache           ),
    .s_axi_arprot       ( arprot            ),
    .s_axi_arvalid      ( arvalid           ),
    .s_axi_arready      ( arready           ),
    .s_axi_rid          ( rid               ),
    .s_axi_rdata        ( rdata             ),
    .s_axi_rresp        ( rresp             ),
    .s_axi_rlast        ( rlast             ),
    .s_axi_rvalid       ( rvalid            ),
    .s_axi_rready       ( rready            )
);


endmodule