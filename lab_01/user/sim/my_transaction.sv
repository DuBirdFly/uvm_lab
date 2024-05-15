/*
 * 1. Class transaction should be extended from uvm_transaction
 * 2. For randomization, every field of the transaction should be defined as "rand"
 */

class my_transaction extends uvm_sequence_item;

    // Define the transaction fields
    rand bit [3:0] src_addr;
    rand bit [3:0] dst_addr;
    rand reg [7:0] payload[$];

    // Define the `uvm_object_utils macro to enable the factory and print methods
    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(src_addr, UVM_ALL_ON)
        `uvm_field_int(dst_addr, UVM_ALL_ON)
        `uvm_field_array_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    // Define the constraints
    constraint Limit {
        src_addr inside {[0:15]};
        dst_addr inside {[0:15]};
        payload.size() inside {[2:4]};
    }

    // Define the constructor
    function new(string name = "my_transaction");
        super.new(name);
    endfunction
endclass
