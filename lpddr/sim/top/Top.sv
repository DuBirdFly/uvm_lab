`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

// defines
`include "define.svh"

// interface
`include "IfApb.sv"

// seq
`include "TrApb.sv"
`include "ApbSeqRand.sv"
`include "ApbSeqInit.sv"

// agent
`include "ApbMasterDrv.sv"
`include "ApbMasterMon.sv"
`include "ApbMasterSeqr.sv"
`include "ApbMasterAgent.sv"

// env
`include "ApbMasterRef.sv"
`include "Env.sv"

// top
`include "Test.sv"

module Top;

    bit pclk;

    IfApb ifApb(pclk);

    always #5 pclk = ~pclk;

    initial begin
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.apbMasterAgent.apbMasterDrv", "vifApb", ifApb);
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.apbMasterAgent.apbMasterMon", "vifApb", ifApb);
        run_test();
    end

    lpddr_ctl u_lpddr_ctl (
        .pclk       (pclk),
        .presetn    (ifApb.presetn),
        .paddr      (ifApb.paddr),
        .pwdata     (ifApb.pwdata),
        .pwrite     (ifApb.pwrite),
        .psel       (ifApb.psel),
        .penable    (ifApb.penable),
        .pready     (ifApb.pready),
        .prdata     (ifApb.prdata)
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
