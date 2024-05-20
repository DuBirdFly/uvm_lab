class my_driver_count extends my_driver;

    `uvm_component_utils(my_driver_count)

    function new(string name = "my_driver_count", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("ABCCCC", "???????????????", UVM_MEDIUM)
    endtask

endclass
