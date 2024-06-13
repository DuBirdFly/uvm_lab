class ApbMasterAgent extends uvm_agent;

    /* Factory Register this Class */
    `uvm_component_utils(ApbMasterAgent)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    ApbMasterSeqr apbMasterSeqr = ApbMasterSeqr::type_id::create("apbMasterSeqr", this);
    ApbMasterDrv  apbMasterDrv  = ApbMasterDrv::type_id::create("apbMasterDrv", this);
    ApbMasterMon  apbMasterMon  = ApbMasterMon::type_id::create("apbMasterMon", this);
    uvm_blocking_put_export #(TrApb) put_export = new("put_export", this);


    /* Constructor Func */
    function new(string name = "ApbMasterAgent", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        apbMasterDrv.seq_item_port.connect(apbMasterSeqr.seq_item_export);
        apbMasterMon.put_port.connect(put_export);
    endfunction

endclass