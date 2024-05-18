module router (
    input   logic           clk,
    input   logic           reset_n,

    input   logic [15:0]    i_frame,
    input   logic [15:0]    i_valid,
    input   logic [15:0]    i_data,

    output  logic [15:0]    o_frame,
    output  logic [15:0]    o_valid,
    output  logic           o_busy,
    output  logic [15:0]    o_data
);

assign o_busy = 1'b0;

endmodule
