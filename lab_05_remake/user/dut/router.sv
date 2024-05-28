module Router (
    input                   clk,
    input                   reset_n,

    input         [3:0]     i_frame,
    input         [3:0]     i_valid,
    input         [3:0]     i_data,
    output  wire  [3:0]     o_grant,

    output  wire  [3:0]     o_frame,
    output  wire  [3:0]     o_valid,
    output  wire  [3:0]     o_data
);

logic [3:0] gnt;

assign gnt = '1;

RouterIPort RouterIPort [3:0] (
    .clk        ( clk           ),
    .reset_n    ( reset_n       ),
    .i_frame    ( i_frame       ),
    .i_data     ( i_data        ),
    .o_dst_addr (               ),
    .o_req      (               ),
    .i_gnt      ( gnt           )
);

endmodule
