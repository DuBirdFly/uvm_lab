class my_transaction extends uvm_sequence_item;

    rand bit [3:0] src_addr;
    rand bit [3:0] dst_addr;
    rand reg [7:0] payload [$];

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(src_addr, UVM_ALL_ON)
        `uvm_field_int(dst_addr, UVM_ALL_ON)
        `uvm_field_queue_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint c_limit_var {
        src_addr inside {[0:15]};
        dst_addr inside {[0:15]};
        payload.size() inside {[2:4]};
    }

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass


