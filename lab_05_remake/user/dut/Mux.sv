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
        // 如果需要更多输入信号,可以继续添加case分支
        default: q = 'z;
    endcase
end

endmodule