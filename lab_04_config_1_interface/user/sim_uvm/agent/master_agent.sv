class master_agent extends uvm_agent;

    `uvm_component_utils(master_agent)

    my_sequencer m_seqr;
    my_driver m_drv;
    my_monitor m_mon;

    function new(string name = "master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Advanced skills:
        //   If "is_active == UVM_ACTIVE", create sequencer, driver and monitor
        //   elif "is_active == UVM_PASSIVE", create only monitor
        if (is_active == UVM_ACTIVE) begin
            m_seqr = my_sequencer::type_id::create("m_seqr", this);
            m_drv = my_driver::type_id::create("m_drv", this);
        end
        m_mon = my_monitor::type_id::create("m_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            m_drv.seq_item_port.connect(m_seqr.seq_item_export);
        end
    endfunction

endclass
