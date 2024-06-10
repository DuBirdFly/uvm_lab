class AgentApb extends uvm_agent;
    
    /* Factory Register this Class */
    `uvm_component_utils(AgentApb)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    SeqrApb seqrApb = SeqrApb::type_id::create("seqrApb", this);
    DrvApb  drvApb  = DrvApb::type_id::create("drvApb", this);
    MonApb  monApb  = MonApb::type_id::create("monApb", this);
    uvm_blocking_put_export #(TrApb) put_export = new("put_export", this);


    /* Constructor Func */
    function new(string name = "AgentApb", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drvApb.seq_item_port.connect(seqrApb.seq_item_export);
        monApb.put_port.connect(put_export);
    endfunction

endclass