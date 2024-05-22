class MySeqItem_da3 extends MySeqItem;

    /* 声明变量 */
    
    /* 注册变量 */
    `uvm_object_utils(MySeqItem_da3)

    /* 约束 */
    constraint c_dst_addr { dst_addr == 6; }

    /* 构造函数 */
    function new(string name = "MySeqItem_da3");
        super.new(name);
    endfunction

endclass
