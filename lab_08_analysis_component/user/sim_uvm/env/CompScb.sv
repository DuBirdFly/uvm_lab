class CompScb extends uvm_scoreboard;
    /* 声明变量 */

    /* 创建对象的句柄 */
    uvm_blocking_get_port #(MySeqItem) sagt2scb_port;

    /* 注册对象 */
    `uvm_component_utils(CompScb)

    /* 构造函数 */
    function new(string name = "CompScb", uvm_component parent);
        super.new(name, parent);
        sagt2scb_port = new("sagt2scb_port", this);
    endfunction

    /* 重写 run_phase */
    virtual task run_phase(uvm_phase phase);
        MySeqItem omon_tr;
        forever begin
            fork
                sagt2scb_port.get(omon_tr);
            join

            `uvm_info("run_phase", {"CompScb has received a omon_tr, ", omon_tr.my_sprint()}, UVM_MEDIUM)
        end
    endtask

endclass