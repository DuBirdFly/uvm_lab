class CompDrv extends uvm_driver #(my_seq_item);

    `uvm_component_utils(CompDrv)

    /* 声明变量 */

    /* 创建对象的句柄 */
    virtual dut_interface dut_vif;

    function new(string name = "CompDrv", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */

        /* uvm_config_db::set() */

    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("DRV_RUN_PHASE", {"\n", req.sprint()}, UVM_MEDIUM)

            #100;
            seq_item_port.item_done();
        end
    endtask

endclass