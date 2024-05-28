`timescale 1ns / 100ps

`define DUMP_VCD

module tb_FixedPrioArb;

    // bit clk = 0;
    // always #5 clk = ~clk;

    // bit rst_n = 1'b0;
    // initial #50 rst_n = 1'b1;

    logic [3:0] req;
    logic [3:0] gnt;

    initial begin
        #100;
        req = 4'b1111;
        #50;
        req = 4'b1110;
        #50;
        req = 4'b1100;
        #50;
        req = 4'b1000;
        #50;
        req = 4'b0000;
        #50;
        $display("\n===============================");
        $display("===== Simulation finished =====");
        $display("===============================\n");
        $finish;
    end

    FixedPrioArb u_FPArb (
        .req        ( req   ),
        .gnt        ( gnt )
    );

    `ifdef DUMP_VCD
        initial begin
            $dumpfile("vsim.vcd");
            $dumpvars(0, tb_FixedPrioArb);
        end
    `endif


endmodule