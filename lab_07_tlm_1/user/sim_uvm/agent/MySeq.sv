class MySeq extends uvm_sequence #(MySeqItem);

    /* 声明变量 */
    int item_num = 0;

    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_object_utils(MySeq)

    /* 构造函数 */
    function new(string name = "MySeq");
        super.new(name);
        /* new() 函数开辟对象空间*/
    endfunction

    function void pre_randomize();
        if (!uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num))
            `uvm_fatal("pre_randomize", "NOT GET ITEM_NUM")
        `uvm_info("pre_randomize", $sformatf("change item_num -> %0d", item_num), UVM_MEDIUM)
    endfunction

    virtual task body();
        MySeqItem tr;

        if (starting_phase != null) starting_phase.raise_objection(this);

        this.pre_randomize();

        repeat(item_num) begin
            // 重写 `uvm_do(req);
            tr = MySeqItem::type_id::create("tr");
            start_item(tr);
            if (!tr.randomize()) `uvm_error("body", "randomize failed")
            finish_item(tr);

            // 从 Drv 获取响应
            get_response(rsp);
            `uvm_info("body", {"\nMySeq get the response:\n", rsp.sprint()}, UVM_MEDIUM)
        end

        #100; // 说明 seq 是带仿真时间的
        `uvm_info("body", $sformatf("MySeq is done"), UVM_MEDIUM)

        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass
