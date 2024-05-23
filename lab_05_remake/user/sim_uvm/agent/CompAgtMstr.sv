class CompAgtMstr extends uvm_agent;
  
    /* 声明变量 */

    /* 创建对象的句柄 */
    CompSeqr compSeqr;
    CompDrv  compDrv;
    CompMon  compMon;

    CfgAgt cfgAgt;

    /* 注册对象 */
    `uvm_component_utils(CompAgtMstr)

    /* 构造函数 */
    function new(string name = "CompAgtMstr", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgAgt)::get(this, "", "cfgAgt", cfgAgt))
            `uvm_fatal("CompAgtMstr", "CfgAgt not found")

        /* uvm_config_db::set() */
        uvm_config_db#(int unsigned)::set(this, "compDrv", "pad_cycle", cfgAgt.pad_cycle);
        uvm_config_db#(virtual IntfDut)::set(this, "compDrv", "vif_dut", cfgAgt.vif_dut);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        // UVM_ACTIVE: 创建 Seqr 和 Drv; UVM_PASSIVE: 只创建 Mon
        if (cfgAgt.is_active == UVM_ACTIVE) begin
            compSeqr = CompSeqr::type_id::create("compSeqr", this);
            compDrv  = CompDrv::type_id::create("compDrv", this);
        end
        compMon = CompMon::type_id::create("compMon", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            compDrv.seq_item_port.connect(compSeqr.seq_item_export);
        end
    endfunction

endclass