class AxiMasterAgent extends uvm_agent;

    /* Factory Register this Class */
    `uvm_component_utils(AxiMasterAgent)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    AxiMasterSeqr axiMasterSeqr = AxiMasterSeqr::type_id::create("axiMasterSeqr", this);
    AxiMasterDrv  axiMasterDrv  = AxiMasterDrv::type_id::create("axiMasterDrv", this);
    // AxiMasterMon  axiMasterMon  = AxiMasterMon::type_id::create("axiMasterMon", this);
    // uvm_blocking_put_export #(TrAxi) put_export_wr = new("put_export_wr", this);
    // uvm_blocking_put_export #(TrAxi) put_export_rd = new("put_export_rd", this);

    /* Constructor Func */
    function new(string name = "AxiMasterAgent", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        axiMasterDrv.seq_item_port.connect(axiMasterSeqr.seq_item_export);
        // axiMasterDrv.put_port.connect(put_export_wr);
        // axiMasterMon.put_port.connect(put_export_rd);
    endfunction

endclass
