class my_driver_count extends uvm_driver;

    `uvm_component_utils(my_driver_count)

    function new(string name = "my_driver_count", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("????????", "???????????????", UVM_MEDIUM)
    endtask

    virtual task run_phase(uvm_phase phase);
        #500;
        forever begin
            seq_item_port.get_next_item(req);
            #100;
            `uvm_info("!!!!!!", "!!!!!!!!!", UVM_MEDIUM)
            seq_item_port.item_done();
        end
    endtask

endclass
