module lpddr_ctl (
    // APB interface
    input               pclk,
    input               presetn,
    input       [15:0]  paddr,
    input       [31:0]  pwdata,
    input               pwrite,
    input               psel,
    input               penable,
    output wire         pready,
    output wire [31:0]  prdata
);

reg [31:0] mem [15:0];

assign pready = 1'b1;
assign prdata = mem[paddr];

always_ff @(posedge pclk) begin
    if (pwrite & psel & penable) begin
        mem[paddr] <= pwdata;
    end
end

endmodule