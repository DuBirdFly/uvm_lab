class Env extends uvm_env;

    /* Factory Register this Class */
    `uvm_component_utils(Env)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    AgentApb  agentApb = AgentApb::type_id::create("agentApb", this);
    RefApb    refApb   = RefApb::type_id::create("refApb", this);

    /* Constructor Func */
    function new(string name = "Env", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        
        /* Create Object Space */

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        agentApb.put_export.connect(refApb.put_imp);
    endfunction

endclass