/*
(1) The transaction class is extends from uvm_sequence_item
(2) Register class-name and variable-name in the factory with MACRO `uvm_object_utils(class-name)`
    1. Before register variable-name, we need to declare the variable with 'rand' keyword 
    2. After register variable-name, we need to constraint the variable with 'constraint' keyword
(3) Override a 'constructor' function: new (string name)
*/

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


