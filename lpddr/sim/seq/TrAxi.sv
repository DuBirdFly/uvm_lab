class TrAxi extends uvm_sequence_item;
    
    /* Factory Register this Class */
    `uvm_object_utils(TrAxi)

    /* Declare Normal Variables */
    rand bit [`AXI_ID_WIDTH - 1:0]     id;
    rand bit [`AXI_ADDR_WIDTH - 1:0]   addr;
    rand bit [`AXI_LEN_WIDTH - 1:0]    len;
         bit [`AXI_SIZE_WIDTH - 1:0]   size;
    rand bit [`AXI_BURST_WIDTH - 1:0]  burst;
    rand bit                           lock;
    rand bit [`AXI_CACHE_WIDTH - 1:0]  cache;
    rand bit [`AXI_PROT_WIDTH - 1:0]   prot;

    rand bit [`AXI_DATA_WIDTH - 1:0]   data[$];
    rand bit [`AXI_STRB_WIDTH - 1:0]   strb;

    bit      [`AXI_RESP_WIDTH - 1:0]   resp;

    /* constraints */
    constraint c_base {
        id == 0;
        addr <= 2 ** `AXI_ADDR_WIDTH - `AXI_STRB_WIDTH * len;  // keep addr in the range
        addr % `AXI_STRB_WIDTH == 0;  // keep the address aligned
        len inside {[0:3]};
        burst == 1;
        lock == 0;
        cache == 0;
        prot == 0;
        data.size() == len + 1;
    }

    constraint c_wstrb {
        $countones(strb) == 2 ** size;
    }

    /* Constructor Func */
    function new(string name = "TrAxi");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual function void pre_rand();
        size = $urandom_range($clog2(`AXI_STRB_WIDTH));
        $display("DBG: size = %0d", size);
    endfunction

    virtual function string my_print();
        string str = "";
        str = {str, $sformatf("id = %0d, addr = 0x%0H, len = %0d(+1), size = %0d (%0d byte)\n", id, addr, len, size, 2**size)};
        str = {str, $sformatf("burst = 0b%d, lock = 0b%d, cache = 0b%d, prot = 0b%d\n", burst, lock, cache, prot)};
        str = {str, $sformatf("strb = 0b%b\n", strb)};
        foreach (data[i]) str = {str, $sformatf("data[%0d] = 0x%h\n", i, data[i])};

        return str;
    endfunction

endclass