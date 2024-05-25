class CompMon extends uvm_monitor;

    /* 声明变量 */

    /* 创建对象的句柄 */
    virtual IntfDut vif_dut;

    /* 注册对象 */
    `uvm_component_utils(CompMon)

    /* 构造函数 */
    function new(string name = "CompMon", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info("build_phase", "BUILD PHASE", UVM_MEDIUM)

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual IntfDut)::get(this, "", "vif_dut", vif_dut))
            `uvm_fatal("CompMon", "NOT GET INTERFACE")

        /* uvm_config_db::set() */

    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        MySeqItem   tr;       // transaction
        int         active_port;
        logic[7:0]  tmp;
        int         cnt;

        forever begin
            tr = MySeqItem::type_id::create("tr");
            active_port = -1;
            cnt = 0;

            @vif_dut.mon_in_cb;
        end
    endtask

endclass