module router (
    input                   clk,
    input                   reset_n,

    input         [3:0]    i_frame,
    input         [3:0]    i_valid,
    input         [3:0]    i_data,
    output  wire  [3:0]    o_grant,

    output  wire  [3:0]    o_frame,
    output  wire  [3:0]    o_valid,
    output  wire  [3:0]    o_data
);

assign o_grant = '1;

endmodule
