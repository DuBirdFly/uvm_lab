module router (
    input                   clk,
    input                   reset_n,

    input         [15:0]    i_frame,
    input         [15:0]    i_valid,
    input         [15:0]    i_data,

    output  wire  [15:0]    o_frame,
    output  wire  [15:0]    o_valid,
    output  wire  [15:0]    o_busy,
    output  wire  [15:0]    o_data
);

assign o_busy = '0;

endmodule
