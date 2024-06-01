class CompDrvNew extends CompDrv;

    /* 声明变量 */

    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_component_utils(CompDrvNew)

    /* 构造函数 */
    function new(string name = "CompDrvNew", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);

        `uvm_info("pre_reset_phase", "Override pre_reset_phase", UVM_MEDIUM)
    endtask

endclass
