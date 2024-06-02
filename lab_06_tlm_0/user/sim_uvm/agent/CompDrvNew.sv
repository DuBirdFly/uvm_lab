class CompDrvNew extends CompDrv;

    /* 声明变量 */

    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_component_utils(CompDrvNew)

    /* 构造函数 */
    function new(string name = "CompDrvNew", uvm_component parent);
        super.new(name, parent);
        `uvm_info("new", "Override new", UVM_MEDIUM)
    endfunction

endclass
