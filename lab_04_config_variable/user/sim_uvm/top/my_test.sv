class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_environment my_env;

    function new(string name = "my_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    // The "start_of_simulation_phase" will be lanuched before the "run_phase"
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        // Print the topology (hirachy) of the UVM-Platfrom
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_env = my_environment::type_id::create("my_env", this);

        // 1st. param: uvm_component cntxt
        // 2nd. param: string        inst_name
        // 3rd. param: string        field_name,
        // 4th. param: T             value
        // After this line, the default_sequence of the m_seqr will be pointed to my_sequence
        // When the UVM-Platfrom run to the run_phase, sequence will be launched,
        // And then driver will get the sequence (transaction) from the sequence
        uvm_config_db #(uvm_object_wrapper)::set(
            this, "*.m_seqr.run_phase", "default_sequence", my_sequence::get_type()
        );

        // Configure the item_num = 5 in the sequencer
        uvm_config_db #(int)::set(this, "*.m_seqr", "item_num", 5);
    endfunction

endclass
