class CompAgtSlv extends uvm_agent;

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompOMon    compOMon;

    CfgAgt      cfgAgt;

    //!uvm_blocking_put_export #(MySeqItem) sagt2scb_export;

    /* 注册对象 */
    `uvm_component_utils(CompAgtSlv)

    /* 构造函数 */
    function new(string name = "CompAgtSlv", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        //!sagt2scb_export = new("sagt2scb_export", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgAgt)::get(this, "", "cfgAgt", cfgAgt))
            `uvm_fatal("CompAgtSlv", "CfgAgt not found")

        /* uvm_config_db::set() */
        uvm_config_db#(virtual IntfDut)::set(this, "compOMon", "vif_dut", cfgAgt.vif_dut);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compOMon = CompOMon::type_id::create("compOMon", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //!compOMon.omon2sagt_port.connect(sagt2scb_export);
    endfunction

endclass