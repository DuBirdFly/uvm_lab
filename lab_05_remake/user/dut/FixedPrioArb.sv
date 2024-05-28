module FixedPrioArb #(
    parameter REQ_WIDTH = 4
)(
    input  logic [REQ_WIDTH - 1:0]    req,
    output logic [REQ_WIDTH - 1:0]    gnt
);

    assign gnt = req & (~(req-1));

endmodule