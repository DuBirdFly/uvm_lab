class my_sequence extends uvm_sequence #(my_transaction);

    `uvm_object_utils(my_sequence)

    int item_num = 3;

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    function void pre_randomize();
        // 1st. argument is the component which is the target of the configuration
        //      it's "m_sequencer" not "my_sequencer", the reason is in book-"UVM实战 I"
        // 2st. argument is the full path of the variable
        // 3rd. argument is the ID of the variable which can be named as you like (Normally, it's the same as the variable name)
        // 4th. argument is the name of the variable
        if (uvm_config_db #(int)::get(m_sequencer, "", "item_num", item_num))
            `uvm_info("MY_SEQUENCE", $sformatf("change item_num to %0d", item_num), UVM_MEDIUM)
        else
            `uvm_error(get_type_name(), "ERROR: item_num is not set")
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(item_num) `uvm_do(req);
        #100;

        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass
