class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        // Print a message every 100 time units
        forever begin
            `uvm_info("MON_RUN_PHASE", "Monitor is running", UVM_MEDIUM)
            #100;
        end
    endtask

endclass
