`define DUMP_VCD
`define DUMP_WLF

import uvm_pkg::*;
`include "uvm_macros.svh"

// dir: interface
`include "IntfDut.sv"

// dir: config
`include "CfgAgt.sv"
`include "CfgEnv.sv"

// dir: agent
`include "MySeqItem.sv"
`include "MySeq.sv"

`include "CompSeqr.sv"
`include "CompDrv.sv"
`include "CompIMon.sv"
`include "CompAgtMstr.sv"

`include "CompDrvNew.sv"
`include "MySeqItem_da3.sv"

// dir: env
`include "CompEnv.sv"

// dir: top
`include "Test.sv"

module Top;

    bit clk;

    IntfDut intf(clk);

    always #5 clk = ~clk;

    initial begin
        uvm_config_db#(virtual IntfDut)::set(
            null, "uvm_test_top", "top_if", intf
        );
        run_test();
    end

    Router dut (
        .clk            (intf.clk),
        .reset_n        (intf.reset_n),

        .i_frame        (intf.i_frame),
        .i_valid        (intf.i_valid),
        .i_data         (intf.i_data),

        .o_valid        (intf.o_valid),
        .o_grant        (intf.o_grant),
        .o_data         (intf.o_data)
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

endmodule

