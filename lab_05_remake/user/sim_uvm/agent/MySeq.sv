class MySeq extends uvm_sequence #(MySeqItem);

    `uvm_object_utils(MySeq)

    /* 声明变量 */
    int item_num = 3;

    /* 构造函数 */
    function new(string name = "MySeq");
        super.new(name);
    endfunction

    function void pre_randomize();
        // 强行修改 rand_mode 并固定值
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(item_num) `uvm_do(req);
        #100;

        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass
