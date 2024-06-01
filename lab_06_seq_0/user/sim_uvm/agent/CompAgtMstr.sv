class CompAgtMstr extends uvm_agent;
  
    /* �������� */

    /* ��������ľ�� */
    CompSeqr compSeqr;
    CompDrv  compDrv;
    CompIMon  compMon;

    CfgAgt cfgAgt;

    /* ע����� */
    `uvm_component_utils(CompAgtMstr)

    /* ���캯�� */
    function new(string name = "CompAgtMstr", uvm_component parent);
        super.new(name, parent);
        /* new() �������ٶ���ռ�*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgAgt)::get(this, "", "cfgAgt", cfgAgt))
            `uvm_fatal("CompAgtMstr", "CfgAgt not found")

        /* uvm_config_db::set() */
        uvm_config_db#(int unsigned)::set(this, "compDrv", "pad_cycle", cfgAgt.pad_cycle);
        uvm_config_db#(virtual IntfDut)::set(this, "compDrv", "vif_dut", cfgAgt.vif_dut);
        uvm_config_db#(virtual IntfDut)::set(this, "compMon", "vif_dut", cfgAgt.vif_dut);


        /* type_id::create() �������� Comp �������ռ� */
        // UVM_ACTIVE: ���� Seqr �� Drv; UVM_PASSIVE: ֻ���� Mon
        if (cfgAgt.is_active == UVM_ACTIVE) begin
            compSeqr = CompSeqr::type_id::create("compSeqr", this);
            compDrv  = CompDrv::type_id::create("compDrv", this);
        end
        compMon = CompIMon::type_id::create("compMon", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            compDrv.seq_item_port.connect(compSeqr.seq_item_export);
        end
    endfunction

endclass