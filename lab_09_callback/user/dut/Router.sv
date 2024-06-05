module Router (
    input                   clk,
    input                   reset_n,

    input         [3:0]     i_frame,
    input         [3:0]     i_valid,
    input         [3:0]     i_data,
    output  logic [3:0]     o_grant,

    output  logic [3:0]     o_valid,
    output  logic [3:0]     o_data
);

////////////////////////////////////
// iport_addr[ 3: 0] : iport[0] 对 4 个 oport 的请求, 最多只能 1 位为 1
// iport_addr[ 7: 4] : iport[1] 对 4 个 oport 的请求, 最多只能 1 位为 1
// iport_addr[11: 8] : iport[2] 对 4 个 oport 的请求, 最多只能 1 位为 1
// iport_addr[15:12] : iport[3] 对 4 个 oport 的请求, 最多只能 1 位为 1
////////////////////////////////////
// arb_req[ 3: 0] : oport[0] 对 4 个 iport 的请求的接收, 最多能有 4 位为 1
// arb_req[ 7: 4] : oport[1] 对 4 个 iport 的请求的接收, 最多能有 4 位为 1
// arb_req[11: 8] : oport[2] 对 4 个 iport 的请求的接收, 最多能有 4 位为 1
// arb_req[15:12] : oport[3] 对 4 个 iport 的请求的接收, 最多能有 4 位为 1
////////////////////////////////////
// arb_gnt[ 3: 0] : oport[0] 对 4 个 iport 的请求的授权, 最多只能 1 位为 1
// arb_gnt[ 7: 4] : oport[1] 对 4 个 iport 的请求的授权, 最多只能 1 位为 1
// arb_gnt[11: 8] : oport[2] 对 4 个 iport 的请求的授权, 最多只能 1 位为 1
// arb_gnt[15:12] : oport[3] 对 4 个 iport 的请求的授权, 最多只能 1 位为 1
////////////////////////////////////
// arb_grant[0] : oport[0] 收到了 arb 的授权. 可以进行 valid-data 的输入
// arb_grant[1] : oport[1] 收到了 arb 的授权. 可以进行 valid-data 的输入
// arb_grant[2] : oport[2] 收到了 arb 的授权. 可以进行 valid-data 的输入
// arb_grant[3] : oport[3] 收到了 arb 的授权. 可以进行 valid-data 的输入
logic [15:0] iport_addr, arb_req, arb_gnt;
logic [3:0]  arb_grant;

assign o_grant = arb_grant;

assign arb_grant[0] = arb_gnt[12] | arb_gnt[8]  | arb_gnt[4] | arb_gnt[0];
assign arb_grant[1] = arb_gnt[13] | arb_gnt[9]  | arb_gnt[5] | arb_gnt[1];
assign arb_grant[2] = arb_gnt[14] | arb_gnt[10] | arb_gnt[6] | arb_gnt[2];
assign arb_grant[3] = arb_gnt[15] | arb_gnt[11] | arb_gnt[7] | arb_gnt[3];

RouterIPort iport [3:0] (
    .clk        ( clk           ),
    .reset_n    ( reset_n       ),

    .i_frame    ( i_frame       ),
    .i_data     ( i_data        ),
    .i_gnt      ( arb_grant     ),

    .o_dst_addr ( iport_addr    )
);

assign arb_req[ 3: 0] = {iport_addr[12], iport_addr[8],  iport_addr[4], iport_addr[0]};
assign arb_req[ 7: 4] = {iport_addr[13], iport_addr[9],  iport_addr[5], iport_addr[1]};
assign arb_req[11: 8] = {iport_addr[14], iport_addr[10], iport_addr[6], iport_addr[2]};
assign arb_req[15:12] = {iport_addr[15], iport_addr[11], iport_addr[7], iport_addr[3]};

FixedPrioArb arb [3:0] (
    .req        ( arb_req       ),
    .gnt        ( arb_gnt       )
);

RouterOPort oport [3:0] (
    .i_valid    ( i_valid       ),
    .i_data     ( i_data        ),
    .i_arb_gnt  ( arb_gnt       ),

    .o_valid    ( o_valid       ),
    .o_data     ( o_data        )
);

endmodule
