class Env extends uvm_env;

    /* Factory Register this Class */
    `uvm_component_utils(Env)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    ApbMasterAgent  apbMasterAgent = ApbMasterAgent::type_id::create("apbMasterAgent", this);
    ApbMasterRef    apbMasterRef   = ApbMasterRef::type_id::create("apbMasterRef", this);

    AxiMasterAgent  axiMasterAgent = AxiMasterAgent::type_id::create("axiMasterAgent", this);
    AxiMasterRef    axiMasterRef   = AxiMasterRef::type_id::create("axiMasterRef", this);

    /* Constructor Func */
    function new(string name = "Env", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        apbMasterAgent.put_export.connect(apbMasterRef.put_imp);
        axiMasterAgent.put_export_wr.connect(axiMasterRef.put_imp_wr);
    endfunction

endclass
