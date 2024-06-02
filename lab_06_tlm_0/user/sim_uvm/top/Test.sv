class Test extends uvm_test;

    /* �������� */

    /* ��������ľ�� */
    CompEnv compEnv;

    CfgEnv cfgEnv;

    /* ע����� */
    `uvm_component_utils(Test)

    /* ���캯�� */
    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);

        /* new() �������ٶ���ռ�*/
        cfgEnv = new("cfgEnv");
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* Set TimeOut */
        uvm_top.set_timeout(5us, 0);  // (��ʱʱ��, �Ƿ���Ա���� set_timeout() ����)

        /* Override ���� */
        set_inst_override_by_type(
            "compEnv.compAgtMstr.*",
            CompDrv::get_type(),
            CompDrvNew::get_type()
        );
        //!: MySeqItem_da3 ����Լ���� dst_addr = 3, ����û����Ч ???
        set_inst_override_by_type(
            "compEnv.compAgtMstr.compSeqr.*",
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

        /* type_id::create() �������� Comp �������ռ� */
        compEnv = CompEnv::type_id::create("compEnv", this);

        /* User Code */
        cfgEnv.is_coverage = 1;
        cfgEnv.is_check = 1;
        cfgEnv.cfgAgt.is_active = UVM_ACTIVE;
        cfgEnv.cfgAgt.pad_cycle = 0;            // 0: ���ӳ� (���ǲ��� grant)

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info("start_of_simulation_phase", "print_topology", UVM_MEDIUM)
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    virtual task run_phase(uvm_phase phase);
        MySeq mySeq;
        mySeq = MySeq::type_id::create("mySeq");
        phase.raise_objection(this);
        mySeq.start(compEnv.compAgtMstr.compSeqr);
        phase.drop_objection(this);
    endtask

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        factory.print();
    endfunction

endclass