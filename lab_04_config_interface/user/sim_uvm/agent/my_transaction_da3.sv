class my_transaction_da3 extends my_transaction;

    `uvm_object_utils(my_transaction_da3)

    constraint c_dst_addr { dst_addr == 3; }

    function new(string name = "my_transaction_da3");
        super.new(name);
    endfunction

endclass
