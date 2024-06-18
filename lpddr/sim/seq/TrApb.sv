class TrApb extends uvm_sequence_item;

    /* Factory Register this Class */
    `uvm_object_utils(TrApb)

    /* Declare Normal Variables */
    rand bit [`APB_ADDR_WIDTH - 1:0]  addr;
    rand bit [`APB_DATA_WIDTH - 1:0]  data;
    rand bit                          write;

    /* constraints */
    constraint c_addr {
        addr inside {[16'h00:16'hF]};
        data inside {[32'h00:32'hFF]};
    }

    /* Constructor Func */
    function new(string name = "TrApb");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual function string get_info();
        // to substitute for $sformatf
        return $sformatf("addr = 0x%0h, data = 0x%0h, write = %0d", addr, data, write);
    endfunction

    virtual function TrApb my_clone();
        TrApb cloned_item;
        cloned_item = new();
        cloned_item.addr = this.addr;
        cloned_item.data = this.data;
        cloned_item.write = this.write;
        return cloned_item;
    endfunction

    virtual function void set_item(bit [15:0] addr, bit [31:0] data, bit write);
        this.addr = addr;
        this.data = data;
        this.write = write;
    endfunction

endclass