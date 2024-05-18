// Just like 'my_driver.sv'

class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name = "my_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        #150;
        `uvm_info("MON_RESET_PHASE", "Monitor 正在进行复位", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        forever begin
            #100;
            `uvm_info("MON_RUN_PHASE", "Monitor 目前只是 100 ns 发一次消息的空转", UVM_MEDIUM)
        end
    endtask

endclass
