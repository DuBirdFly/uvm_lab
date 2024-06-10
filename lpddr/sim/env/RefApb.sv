class RefApb extends uvm_component;

    /* Factory Register this Class */
    `uvm_component_utils(RefApb)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    uvm_blocking_put_imp #(TrApb, RefApb) put_imp = new("put_imp", this);

    /* Constructor Func */
    function new(string name = "RefApb", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    task put (TrApb trApb);
        `uvm_info("put", trApb.my_print(), UVM_MEDIUM)
    endtask

endclass