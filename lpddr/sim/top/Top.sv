`define DUMP_VCD
`define DUMP_WLF

import uvm_pkg::*;
`include "uvm_macros.svh"

// interface
`include "IfApb.sv"

// seq
`include "TrApb.sv"
`include "SeqApbRand.sv"
`include "SeqApbInit.sv"

// agent
`include "DrvApb.sv"
`include "MonApb.sv"
`include "SeqrApb.sv"
`include "AgentApb.sv"

// env
`include "RefApb.sv"
`include "Env.sv"

// top
`include "Test.sv"

module Top;

    bit pclk;

    IfApb ifApb(pclk);

    always #5 pclk = ~pclk;

    initial begin
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.agentApb.drvApb", "vifApb", ifApb);
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.agentApb.monApb", "vifApb", ifApb);
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
