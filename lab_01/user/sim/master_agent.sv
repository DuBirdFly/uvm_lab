class master_agent extends uvm_agent;

    `uvm_component_utils(master_agent)

    // Declare headers of sequencer, driver, monitor
    my_sequencer    m_seqr;
    my_driver       m_drv;
    my_monitor      m_mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Create sequencer, driver, monitor Object(对象) and connect them to each header
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // If is_active is UVM_ACTIVE, create sequencer and driver
        // Else if is_active is UVM_PASSIVE, create only monitor
        if (is_active == UVM_ACTIVE) begin
            // Use UVM factory to create objects
            m_seqr = my_sequencer::type_id::create("m_seqr", this);
            m_drv = my_driver::type_id::create("m_drv", this);
        end
        m_mon = my_monitor::type_id::create("m_mon", this);
    endfunction

    // Connect sequencer and driver with "seq_item_port.connect()"
    // To allow transaction communication them
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            m_drv.seq_item_port.connect(m_seqr.seq_item_export);
        end
    endfunction

endclass
