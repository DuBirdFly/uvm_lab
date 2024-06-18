class AxiMasterRef extends uvm_component;
  
    /* Factory Register this Class */
    `uvm_component_utils(AxiMasterRef)

    /* Declare Normal Variables */
    logic [`AXI_DATA_WIDTH - 1:0] mem [2**(`AXI_ADDR_WIDTH - $clog2(`AXI_STRB_WIDTH)) - 1:0];

    /* Declare Object Handles */
    uvm_blocking_put_imp #(TrAxi, AxiMasterRef) put_imp_wr = new("put_imp", this);

    /* Constructor Func */
    function new(string name = "AxiMasterRef", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    task put (TrAxi tr);
        $display(tr.get_info());

        for (int i = 0; i <= tr.len; i++) begin
            bit [`AXI_DATA_WIDTH - 1:0] data_tmp = tr.data[i];
            bit [`AXI_STRB_WIDTH - 1:0] strb_tmp = tr.align_strb[i];
            for (int j = 0; j < `AXI_STRB_WIDTH; j++) begin
                if (strb_tmp[j]) mem[tr.mem_addr[i]][j * 8 +: 8] = data_tmp[j * 8 +: 8];
            end
        end
    endtask

    function void peek_mem();
        $display("\n============================== PEEK REF MEMORY ==============================");
        // for (int i = 0; i < 2**(`AXI_ADDR_WIDTH - $clog2(`AXI_STRB_WIDTH)); i++) begin
        for (int i = 0; i < $size(mem); i++) begin
            logic [`AXI_DATA_WIDTH - 1:0] data = mem[i];
            if (data != 0) $display("mem[0x%0h] = %h", i, data);
        end
        $display("=============================================================================\n");
    endfunction

endclass
