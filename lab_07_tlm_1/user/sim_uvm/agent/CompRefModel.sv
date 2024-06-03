class CompRefModel extends uvm_component;

    /* 声明变量 */

    /* 创建对象的句柄 */
    // 因为 RefModel 是 SeqItem 的消费者，所以 RefModel 需要一个 SeqItem 的输入端口 (import = *_imp)
    uvm_blocking_put_imp#(MySeqItem, CompRefModel) imon2ref_imp;   // imonitor_to_refmodel_import

    /* 注册对象 */
    `uvm_component_utils(CompRefModel)

    /* 构造函数 */
    function new(string name = "CompRefModel", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        this.imon2ref_imp = new("imon2ref_imp", this);
    endfunction

    task put (MySeqItem tr);
        `uvm_info("put", {"\nCompRefModel 接收到一个 MySeqItem, 内容为\n", tr.sprint()}, UVM_MEDIUM)
    endtask

endclass