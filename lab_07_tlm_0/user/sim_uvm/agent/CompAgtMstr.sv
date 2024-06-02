class CompAgtMstr extends uvm_agent;
  
    /* 声明变量 */

    /* 创建对象的句柄 */
    CompSeqr    compSeqr;
    CompDrv     compDrv;
    CompIMon    compIMon;
    
    CfgAgt      cfgAgt;

    uvm_blocking_put_export #(MySeqItem) magt2ref_export;   // master_agent_to_refmodel_export

    /* 注册对象 */
    `uvm_component_utils(CompAgtMstr)

    /* 构造函数 */
    function new(string name = "CompAgtMstr", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        this.magt2ref_export = new("magt2ref_export", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgAgt)::get(this, "", "cfgAgt", cfgAgt))
            `uvm_fatal("CompAgtMstr", "CfgAgt not found")

        /* uvm_config_db::set() */
        uvm_config_db#(int unsigned)::set(this, "compDrv", "pad_cycle", cfgAgt.pad_cycle);
        uvm_config_db#(virtual IntfDut)::set(this, "compDrv", "vif_dut", cfgAgt.vif_dut);
        uvm_config_db#(virtual IntfDut)::set(this, "compIMon", "vif_dut", cfgAgt.vif_dut);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        // UVM_ACTIVE: 创建 Seqr 和 Drv; UVM_PASSIVE: 只创建 Mon
        if (cfgAgt.is_active == UVM_ACTIVE) begin
            compSeqr = CompSeqr::type_id::create("compSeqr", this);
            compDrv  = CompDrv::type_id::create("compDrv", this);
        end
        compIMon = CompIMon::type_id::create("compIMon", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            // seq_item_port 是 uvm_sequencer 这个 uvm 类内建的成员: uvm_seq_item_pull_imp #(REQ, RSP, this_type) seq_item_export;
            // 非常秀的是, 这里是一个 *_imp, 却取名为 *_export, 也许是因为用的 fifo tml ?
            compDrv.seq_item_port.connect(compSeqr.seq_item_export);
        end
        compIMon.imon2ref_port.connect(this.magt2ref_export);
    endfunction

endclass