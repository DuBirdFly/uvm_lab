// Just like 'my_driver.sv'

class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("MON_RUN_PHASE", "Monitor 目前只是 100 ns 发一次消息的空转", UVM_MEDIUM)
            #100;
        end
    endtask

endclass
