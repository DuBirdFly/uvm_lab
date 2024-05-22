class MySeqItem extends uvm_sequence_item;

    /* 声明变量 */
    rand bit [3:0] src_addr;
    rand bit [3:0] dst_addr;
    rand reg [7:0] payload [$];

    /* 注册变量 */
    `uvm_object_utils_begin(MySeqItem)
        `uvm_field_int(src_addr, UVM_ALL_ON)
        `uvm_field_int(dst_addr, UVM_ALL_ON)
        `uvm_field_queue_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    /* 约束 */
    constraint c_limit_var {
        src_addr inside {[0:15]};
        dst_addr inside {[0:15]};
        payload.size() inside {[2:4]};
    }

    /* 构造函数 */
    function new(string name = "MySeqItem");
        super.new(name);
    endfunction

endclass
