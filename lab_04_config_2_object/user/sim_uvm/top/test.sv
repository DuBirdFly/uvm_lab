class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_environment my_env;

    function new(string name = "my_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_env = my_environment::type_id::create("my_env", this);

        set_inst_override_by_type("my_env.m_agent.m_seqr.*", my_transaction::get_type(), my_transaction_da3::get_type());
        set_inst_override_by_type("my_env.m_agent.m_drv.*", my_driver::get_type(), my_driver_count::get_type());

        uvm_config_db #(uvm_object_wrapper)::set(this, "*.m_seqr.run_phase", "default_sequence", my_sequence::get_type());
        uvm_config_db #(int)::set(this, "*.m_seqr", "item_num", 5);
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        factory.print();
    endfunction

endclass
