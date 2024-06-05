class CompRefModel extends uvm_component;
    /* 声明变量 */

    /* 创建对象的句柄 */
    uvm_blocking_get_port #(MySeqItem) imon2ref_port;
    uvm_blocking_put_port #(MySeqItem) ref2scb_port;

    /* 注册对象 */
    `uvm_component_utils(CompRefModel)

    /* 构造函数 */
    function new(string name = "CompRefModel", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        imon2ref_port = new("imon2ref_port", this);
        ref2scb_port = new("ref2scb_port", this);
    endfunction

    /* 重写 run_phase */
    virtual task run_phase(uvm_phase phase);
        MySeqItem tr;
        forever begin
            imon2ref_port.get(tr);
            `uvm_info("run_phase", {"CompRefModel has received a tr from imon, ", tr.my_sprint()}, UVM_MEDIUM)
            ref2scb_port.put(tr);
            `uvm_info("run_phase", {"CompRefModel has sent a tr to scoreboard, ", tr.my_sprint()}, UVM_MEDIUM)
        end
    endtask

endclass