class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_environment my_env;

    function new(string name = "", uvm_component parent);
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

        // 1st. param: the location to invoke the "set method" is THIS test
        // 2nd. param: the relative-path of the configured object
        // 3rd. param: the identifier of the target object
        // 4th. param: the type of the seqr which will be lancuhed
        // After this line, the default_sequence of the m_seqr will be pointed to my_sequence
        // When the UVM-Platfrom run to the run_phase, sequence will be launched,
        // And then driver will get the sequence (transaction) from the sequence
        uvm_config_db #(uvm_object_wrapper)::set(
            this, "*.m_seqr.run_phase", "default_sequence",
            my_sequence::get_type()
        );
    endfunction

endclass
