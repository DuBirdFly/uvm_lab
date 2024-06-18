import uvm_pkg::*;
`include "uvm_macros.svh"

// defines
`include "define.svh"

// interface
`include "IfApb.sv"
`include "IfAxi.sv"

// seq
`include "TrApb.sv"
`include "ApbSeqRand.sv"
`include "ApbSeqInit.sv"

`include "TrAxi.sv"
`include "AxiSeqRand.sv"
`include "AxiSeqFocus.sv"

// agent
`include "ApbMasterDrv.sv"
`include "ApbMasterMon.sv"
`include "ApbMasterSeqr.sv"
`include "ApbMasterAgent.sv"

`include "AxiMasterDrv.sv"
`include "AxiMasterSeqr.sv"
`include "AxiMasterAgent.sv"

// env
`include "ApbMasterRef.sv"
`include "AxiMasterRef.sv"
`include "Env.sv"

// top
`include "Test.sv"

module Top;

    bit pclk;
    always #10 pclk = ~pclk;
    IfApb ifApb (pclk);

    bit aclk;
    always #5 aclk = ~aclk;
    IfAxi ifAxi (aclk);

    initial begin
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.apbMasterAgent.apbMasterDrv", "vifApb", ifApb);
        uvm_config_db#(virtual IfApb)::set(null, "uvm_test_top.env.apbMasterAgent.apbMasterMon", "vifApb", ifApb);

        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top", "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMasterAgent.axiMasterDrv", "vifAxi", ifAxi);
        run_test();
    end

    lpddr_ctrl u_lpddr_ctrl (
        .pclk       ( pclk              ),
        .presetn    ( ifApb.presetn     ),
        .paddr      ( ifApb.paddr       ),
        .pwdata     ( ifApb.pwdata      ),
        .pwrite     ( ifApb.pwrite      ),
        .psel       ( ifApb.psel        ),
        .penable    ( ifApb.penable     ),
        .pready     ( ifApb.pready      ),
        .prdata     ( ifApb.prdata      ),

        .aclk       ( aclk              ),
        .aresetn    ( ifAxi.aresetn     ),

        .awid       ( ifAxi.awid        ),
        .awaddr     ( ifAxi.awaddr      ),
        .awlen      ( ifAxi.awlen       ),
        .awsize     ( ifAxi.awsize      ),
        .awburst    ( ifAxi.awburst     ),
        .awlock     ( ifAxi.awlock      ),
        .awcache    ( ifAxi.awcache     ),
        .awprot     ( ifAxi.awprot      ),
        .awvalid    ( ifAxi.awvalid     ),
        .awready    ( ifAxi.awready     ),

        .wdata      ( ifAxi.wdata       ),
        .wstrb      ( ifAxi.wstrb       ),
        .wlast      ( ifAxi.wlast       ),
        .wvalid     ( ifAxi.wvalid      ),
        .wready     ( ifAxi.wready      ),

        .bid        ( ifAxi.bid         ),
        .bresp      ( ifAxi.bresp       ),
        .bvalid     ( ifAxi.bvalid      ),
        .bready     ( ifAxi.bready      ),

        .arid       ( ifAxi.arid        ),
        .araddr     ( ifAxi.araddr      ),
        .arlen      ( ifAxi.arlen       ),
        .arsize     ( ifAxi.arsize      ),
        .arburst    ( ifAxi.arburst     ),
        .arlock     ( ifAxi.arlock      ),
        .arcache    ( ifAxi.arcache     ),
        .arprot     ( ifAxi.arprot      ),
        .arvalid    ( ifAxi.arvalid     ),
        .arready    ( ifAxi.arready     ),

        .rid        ( ifAxi.rid         ),
        .rdata      ( ifAxi.rdata       ),
        .rresp      ( ifAxi.rresp       ),
        .rlast      ( ifAxi.rlast       ),
        .rvalid     ( ifAxi.rvalid      ),
        .rready     ( ifAxi.rready      )
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
