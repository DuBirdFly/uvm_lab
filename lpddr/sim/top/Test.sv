class Test extends uvm_test;

    /* Factory Register this Class */
    `uvm_component_utils(Test)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    Env env = Env::type_id::create("env", this);

    /* Constructor Func */
    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        uvm_top.set_timeout(5us, 0);

        /* Override */

        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info("start_of_simulation_phase", "print_topology", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        ApbSeqRand apbSeqRand = ApbSeqRand::type_id::create("apbSeqRand");
        ApbSeqInit apbSeqInit = ApbSeqInit::type_id::create("apbSeqInit");

        AxiSeqRand axiSeqRand = AxiSeqRand::type_id::create("axiSeqRand");

        phase.raise_objection(this);
        apbSeqInit.start(env.apbMasterAgent.apbMasterSeqr);
        #500;
        apbSeqRand.start(env.apbMasterAgent.apbMasterSeqr);
        #500;
        axiSeqRand.start(env.axiMasterAgent.axiMasterSeqr);
        #500;
        phase.drop_objection(this);

    endtask

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("report_phase", "print_report", UVM_MEDIUM)
        factory.print();
    endfunction

endclass

