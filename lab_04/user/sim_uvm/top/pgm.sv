program automatic pgm;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "my_transaction.sv"
    `include "my_sequence.sv"
    `include "my_sequencer.sv"
    `include "my_driver.sv"
    `include "my_monitor.sv"
    `include "master_agent.sv"
    `include "my_environment.sv"
    `include "my_test.sv"

    `include "my_transaction_da3.sv"
    `include "my_driver_count.sv"
    `include "my_test_da3.sv"

    initial begin
        // run_test() is a UVM task
        run_test();
    end

endprogram
