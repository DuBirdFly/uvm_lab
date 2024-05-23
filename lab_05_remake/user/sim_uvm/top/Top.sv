`define DUMP_VCD
`define DUMP_WLF

import uvm_pkg::*;
`include "uvm_macros.svh"

// dir: interface
`include "IntfDut.sv"

// dir: agent
`include "MySeqItem.sv"
`include "MySeq.sv"

`include "CompSeqr.sv"
`include "CompDrv.sv"
`include "CompMon.sv"
`include "CompAgtMstr.sv"

`include "CompDrvNew.sv"
`include "MySeqItem_da3.sv"

// dir: env
`include "CompEnv.sv"

// dir: top
`include "Test.sv"

module Top;

    bit clk;

    IntfDut inf(clk);

    always #5 clk = ~clk;

    initial begin
        uvm_config_db#(virtual IntfDut)::set(null, "*.compAgtMstr.*", "dut_vif", inf);
        run_test();
    end

    router dut (
        .clk            (inf.clk),
        .reset_n        (inf.reset_n),

        .i_frame        (inf.i_frame),
        .i_valid        (inf.i_valid),
        .i_data         (inf.i_data),

        .o_frame        (inf.o_frame),
        .o_valid        (inf.o_valid),
        .o_busy         (inf.o_busy),
        .o_data         (inf.o_data)
    );

    `ifdef DUMP_VCD
        initial begin
            $dumpfile("vsim.vcd");
            $dumpvars(0, Top);
        end
    `endif

    `ifdef DUMP_WLF
        initial begin
            $wlfdumpvars();
        end
    `endif

    initial begin
        #50000;
        $display("//////////////////////////////////////////");
        $display("///////// ERROR: RUN OUT OF TIME /////////");
        $display("//////////////////////////////////////////");
        $finish;
    end

endmodule

