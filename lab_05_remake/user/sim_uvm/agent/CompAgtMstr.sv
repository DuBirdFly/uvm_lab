class CompAgtMstr extends uvm_agent;
  
    `uvm_component_utils(CompAgtMstr)

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompSeqr compSeqr;
    CompDrv  compDrv;
    CompMon  compMon;

    function new(string name = "CompAgtMstr", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */

        /* uvm_config_db::set() */

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        // UVM_ACTIVE: 创建 Seqr 和 Drv; UVM_PASSIVE: 只创建 Mon
        if (is_active == UVM_ACTIVE) begin
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