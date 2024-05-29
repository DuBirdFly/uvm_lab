//////////////////////////////////////////////////////
module Mux #(
    parameter   N = 4
) (
    input   logic [N-1:0]           d,
    input   logic [$clog2(N)-1:0]   sel,
    output  logic                   q
);

always_comb begin
    case (sel)
        0: q = d[0];
        1: q = d[1];
        2: q = d[2];
        3: q = d[3];
        default: q = 'z;
    endcase
end

endmodule

//////////////////////////////////////////////////////
module Decoder #(
    parameter   N = 4
) (
    input   logic                   EN,
    input   logic [$clog2(N)-1:0]   A,
    output  logic [N-1:0]           Y
);

    assign Y = EN ? (1 << A) : '0;

endmodule

//////////////////////////////////////////////////////
module FixedPrioArb #(
    parameter N = 4
)(
    input  logic [N - 1:0]    req,
    output logic [N - 1:0]    gnt
);

    assign gnt = req & (~(req-1));

endmodule