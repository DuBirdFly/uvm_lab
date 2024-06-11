`include "define.svh"

module lpddr_ctl (
    // APB interface
    input                           pclk,
    input                           presetn,
    input       [`APB_DEPTH - 1:0]  paddr,
    input       [`APB_WIDTH - 1:0]  pwdata,
    input                           pwrite,
    input                           psel,
    input                           penable,
    output wire                     pready,
    output wire [`APB_WIDTH - 1:0]  prdata
);

reg [`APB_WIDTH - 1:0] mem [`APB_DEPTH - 1:0];

assign pready = 1'b1;
assign prdata = mem[paddr];

always_ff @(posedge pclk) begin
    if (pwrite & psel & penable) begin
        mem[paddr] <= pwdata;
    end
end

endmodule