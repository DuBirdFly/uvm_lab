class MySeqItem_da3 extends MySeqItem;

    /* 声明变量 */
    
    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_object_utils(MySeqItem_da3)

    /* 约束 */
    constraint c_dst_addr { dst_addr == 3; }

    /* 构造函数 */
    function new(string name = "MySeqItem_da3");
        super.new(name);
        `uvm_info(get_type_name(), "Override new func", UVM_MEDIUM)
        /* new() 函数开辟对象空间*/
    endfunction

endclass
