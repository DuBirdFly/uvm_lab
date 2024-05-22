class Test extends uvm_test;

    `uvm_component_utils(Test)

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompEnv compEnv;

    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);

        /* new() 函数开辟 Object 对象的空间*/

    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* Override 对象 */
        set_inst_override_by_type(
            "compEnv.compAgtMstr.*",
            CompDrv::get_type(),
            CompDrvNew::get_type()
        );
        set_inst_override_by_type(
            "compEnv.compAgtMstr.compSeqr.*",
            MySeqItem::get_type(),
            MySeqItem_da3::get_type()
        );

        /* uvm_config_db::get() */

        /* uvm_config_db::set() */
        uvm_config_db#(uvm_object_wrapper)::set(this, "*.compSeqr.run_phase", "default_sequence", MySeq::get_type());

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compEnv = CompEnv::type_id::create("compEnv", this);

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        factory.print();
    endfunction

endclass