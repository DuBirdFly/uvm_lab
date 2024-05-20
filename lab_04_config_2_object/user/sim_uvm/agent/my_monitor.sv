class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name = "my_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        // forever begin
        // end
    endtask

endclass
