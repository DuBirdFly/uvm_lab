class CompScb extends uvm_scoreboard;
    /* 声明变量 */

    /* 创建对象的句柄 */
    uvm_blocking_get_port #(MySeqItem) sagt2scb_port;
    uvm_blocking_get_port #(MySeqItem) ref2scb_port;

    /* 注册对象 */
    `uvm_component_utils(CompScb)

    /* 构造函数 */
    function new(string name = "CompScb", uvm_component parent);
        super.new(name, parent);
        sagt2scb_port = new("sagt2scb_port", this);
        ref2scb_port = new("ref2scb_port", this);
    endfunction

    /* 重写 run_phase */
    virtual task run_phase(uvm_phase phase);
        MySeqItem ref_tr;
        MySeqItem omon_tr;
        forever begin
            fork
                sagt2scb_port.get(omon_tr);
                ref2scb_port.get(ref_tr);
            join

            omon_tr.src_addr = ref_tr.src_addr;

            `uvm_info("run_phase", {"CompScb has received a ref_tr, ", ref_tr.my_sprint()}, UVM_MEDIUM)
            `uvm_info("run_phase", {"CompScb has received a omon_tr, ", omon_tr.my_sprint()}, UVM_MEDIUM)

            if (omon_tr.compare(ref_tr)) begin
                `uvm_info("run_phase", "CHECK PASS !!!!", UVM_MEDIUM)
            end
            else begin
                `uvm_error("run_phase", "CHECK FAIL !!!!")
            end
        end
    endtask

endclass