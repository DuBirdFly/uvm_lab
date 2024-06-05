module RouterOPort (
    input         [3:0]    i_valid,
    input         [3:0]    i_data,
    input         [3:0]    i_arb_gnt,   // 某个 oport 对 4 个 iport 的请求的授权, 最多只能 1 位为 1
    output logic           o_valid,
    output logic           o_data
);

assign o_valid = |(i_arb_gnt & i_valid);
assign o_data  = |(i_arb_gnt & i_data);

// always_comb begin
//     case (i_arb_gnt)
//         'b0001: o_valid = i_valid[0];
//         'b0010: o_valid = i_valid[1];
//         'b0100: o_valid = i_valid[2];
//         'b1000: o_valid = i_valid[3];
//         default: o_valid = 1'b0;
//     endcase
// end

// always_comb begin
//     case (i_arb_gnt)
//         'b0001: o_data = i_data[0];
//         'b0010: o_data = i_data[1];
//         'b0100: o_data = i_data[2];
//         'b1000: o_data = i_data[3];
//         default: o_data = 4'b0;
//     endcase
// end

endmodule