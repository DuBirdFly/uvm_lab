class Test extends uvm_test;

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompEnv compEnv;

    CfgEnv cfgEnv;

    /* 注册对象 */
    `uvm_component_utils(Test)

    /* 构造函数 */
    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);

        /* new() 函数开辟对象空间*/
        cfgEnv = new("cfgEnv");
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* Set TimeOut */
        uvm_top.set_timeout(5us, 0);  // (超时时间, 是否可以被别的 set_timeout() 覆盖)

        /* Override 对象 */
        set_inst_override_by_type(
            "compEnv.compAgtMstr.*",
            CompDrv::get_type(),
            CompDrvNew::get_type()
        );
        //!: MySeqItem 到底在哪个路径下? Test 中例化了 MySeq?
        // set_inst_override_by_type(
        //     "compEnv.compAgtMstr.compSeqr.*",
        //     MySeqItem::get_type(),
        //     MySeqItem_da3::get_type()
        // );
        set_type_override_by_type(
            MySeqItem::get_type(),
            MySeqItem_da3::get_type()
        );

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual IntfDut)::get(this, "", "top_if", cfgEnv.cfgAgt.vif_dut))
           `uvm_fatal("NOVIF", "uvm_config_db::get(vif) failed");

        /* uvm_config_db::set() */
        // uvm_config_db#(uvm_object_wrapper)::set(this, "*.compSeqr.run_phase", "default_sequence", MySeq::get_type());
        uvm_config_db#(CfgEnv)::set(this, "compEnv", "cfgEnv", cfgEnv);
        uvm_config_db#(int)::set(this, "compEnv.compAgtMstr.compSeqr", "item_num", 3);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compEnv = CompEnv::type_id::create("compEnv", this);

        /* User Code */
        cfgEnv.is_coverage = 1;
        cfgEnv.is_check = 1;
        cfgEnv.cfgAgt.is_active = UVM_ACTIVE;
        cfgEnv.cfgAgt.pad_cycle = 0;            // 0: ADDR 和 DATA 之间无延迟 (除非不给 grant)

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("start_of_simulation_phase", "print_topology", UVM_MEDIUM)
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    virtual task run_phase(uvm_phase phase);
        MySeq mySeq;

        `uvm_info("run_phase", "create mySeq; mySeq --> compEnv.compAgtMstr.compSeqr", UVM_MEDIUM)
        mySeq = MySeq::type_id::create("mySeq");
        phase.raise_objection(this);
        mySeq.start(compEnv.compAgtMstr.compSeqr);
        phase.drop_objection(this);
    endtask

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase", "print_factory", UVM_MEDIUM)
        factory.print();
    endfunction

endclass