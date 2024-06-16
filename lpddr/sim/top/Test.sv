class Test extends uvm_test;

    /* Factory Register this Class */
    `uvm_component_utils(Test)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfAxi vifAxi;
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
        if (!uvm_config_db#(virtual IfAxi)::get(this, "", "vifAxi", vifAxi))
            `uvm_fatal("NO_IFAXI", "No IfAxi Interface Specified")
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info("start_of_simulation_phase", "print_topology", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        ApbSeqRand apbSeqRand = ApbSeqRand::type_id::create("apbSeqRand");
        ApbSeqInit apbSeqInit = ApbSeqInit::type_id::create("apbSeqInit");

        AxiSeqFocus axiSeqFocus;
        AxiSeqRand axiSeqRand;

        phase.raise_objection(this);

        apbSeqInit.start(env.apbMasterAgent.apbMasterSeqr);
        #200;
        apbSeqRand.start(env.apbMasterAgent.apbMasterSeqr);
        #200;
        `ifdef CASE_0
            axiSeqFocus = AxiSeqFocus::type_id::create("axiSeqFocus");
            axiSeqFocus.start(env.axiMasterAgent.axiMasterSeqr);
        `else
            axiSeqRand = AxiSeqRand::type_id::create("axiSeqRand");
            axiSeqRand.start(env.axiMasterAgent.axiMasterSeqr);
        `endif

        #500;

        vifAxi.peek_mem();

        phase.drop_objection(this);

    endtask

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("report_phase", "print_report", UVM_MEDIUM)
        factory.print();
    endfunction

endclass

