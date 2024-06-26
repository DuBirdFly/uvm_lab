class ApbMasterRef extends uvm_component;

    /* Factory Register this Class */
    `uvm_component_utils(ApbMasterRef)

    /* Declare Normal Variables */
    logic [`APB_DATA_WIDTH - 1:0] mem [`APB_ADDR_WIDTH-1:0];

    /* Declare Object Handles */
    uvm_blocking_put_imp #(TrApb, ApbMasterRef) put_imp = new("put_imp", this);

    /* Constructor Func */
    function new(string name = "ApbMasterRef", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    task put (TrApb trApb);
        if (trApb.write)
            mem[trApb.addr] = trApb.data;
        else begin
            if (trApb.data == mem[trApb.addr])
                `uvm_info("put", "Check PASS !!", UVM_MEDIUM)
            else begin
                `uvm_error("put", "Check FAIL !!")
                $display("ApbMasterRef: Addr: %0d, Data: %0d", trApb.addr, trApb.data);
                $display("IfApb:  Addr: %0d, Data: %0d", trApb.addr, mem[trApb.addr]);
            end
        end
    endtask

endclass