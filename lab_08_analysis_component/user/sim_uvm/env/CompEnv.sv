class CompEnv extends uvm_env;

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompAgtMstr compAgtMstr;
    CompAgtSlv compAgtSlv;
    CompRefModel compRefModel;
    CompScb compScb;

    CfgEnv cfgEnv;

    uvm_tlm_analysis_fifo #(MySeqItem) magt2ref_fifo;
    uvm_tlm_analysis_fifo #(MySeqItem) sagt2scb_fifo;

    /* 注册对象 */
    `uvm_component_utils(CompEnv)

    /* 构造函数 */
    function new(string name = "CompEnv", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        magt2ref_fifo = new("magt2ref_fifo", this);
        sagt2scb_fifo = new("sagt2scb_fifo", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgEnv)::get(this, "", "cfgEnv", cfgEnv))
            `uvm_fatal("CompEnv", "CfgEnv not found")

        /* uvm_config_db::set() */
        uvm_config_db#(CfgAgt)::set(this, "compAgtMstr", "cfgAgt", cfgEnv.cfgAgt);
        uvm_config_db#(CfgAgt)::set(this, "compAgtSlv",  "cfgAgt", cfgEnv.cfgAgt);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compAgtMstr = CompAgtMstr::type_id::create("compAgtMstr", this);
        compAgtSlv  = CompAgtSlv::type_id::create("compAgtSlv", this);
        compRefModel = CompRefModel::type_id::create("compRefModel", this);

        /* User Code*/
        if (cfgEnv.is_coverage == 1)
            `uvm_info("build_phase", "Coverage is enabled", UVM_MEDIUM)
        if (cfgEnv.is_check == 1) begin
            `uvm_info("build_phase", "ScoreBoard for check is enabled", UVM_MEDIUM)
            compScb = CompScb::type_id::create("compScb", this);
        end

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //////////////////////////////////////////////////////////////////
        compAgtMstr.magt2ref_export.connect(magt2ref_fifo.blocking_put_export);

        compRefModel.imon2ref_port.connect(magt2ref_fifo.blocking_get_export);
        //////////////////////////////////////////////////////////////////
        compAgtSlv.sagt2scb_export.connect(sagt2scb_fifo.blocking_put_export);
        compScb.sagt2scb_port.connect(sagt2scb_fifo.blocking_get_export);

    endfunction

endclass