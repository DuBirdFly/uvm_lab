import uvm_pkg::*;
`include "uvm_macros.svh"

`define DUMP_VCD
`define DUMP_WLF

`include "dut_interface.sv"
`include "my_transaction.sv"
`include "my_sequence.sv"
`include "my_driver.sv"
`include "my_sequencer.sv"
`include "my_monitor.sv"
`include "master_agent.sv"
`include "my_environment.sv"

`include "my_transaction_da3.sv"
`include "my_driver_count.sv"

`include "test.sv"

module top;

    bit clk;

    dut_interface inf(clk);

    always #5 clk = ~clk;

    initial begin
        uvm_config_db#(virtual dut_interface)::set(null, "*.m_agent.*", "vif", inf);
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
            $dumpvars(0, top);
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
