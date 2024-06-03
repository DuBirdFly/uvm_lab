class CompRefModel extends uvm_component;

    /* 声明变量 */

    /* 创建对象的句柄 */
    uvm_blocking_get_port #(MySeqItem) imon2ref_port;               // imonitor_to_refmodel_port

    /* 注册对象 */
    `uvm_component_utils(CompRefModel)

    /* 构造函数 */
    function new(string name = "CompRefModel", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        this.imon2ref_port = new("imon2ref_port", this);
    endfunction

    /* 重写 run_phase */
    virtual task run_phase(uvm_phase phase);
        MySeqItem item;
        `uvm_info("run_phase", "CompRefModel try to get item from imonitor", UVM_MEDIUM)
        forever begin
            imon2ref_port.get(item);
            `uvm_info("run_phase", {"CompRefModel has received a item, ", item.my_sprint()}, UVM_MEDIUM)
        end
    endtask

endclass