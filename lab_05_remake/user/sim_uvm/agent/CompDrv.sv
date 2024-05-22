class CompDrv extends uvm_driver #(MySeqItem);

    `uvm_component_utils(CompDrv)

    /* 声明变量 */
    int unsigned pad_cycles = 5;

    /* 创建对象的句柄 */
    virtual dut_interface dut_vif;

    function new(string name = "CompDrv", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual dut_interface)::get(this, "*", "dut_vif", dut_vif))
            `uvm_fatal("CompDrv", "NOT GET INTERFACE")

        /* uvm_config_db::set() */

    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("CompDrv", "PRE_RESET_PHASE START", UVM_MEDIUM)

        phase.raise_objection(this);    
        dut_vif.drv_cb.reset_n      <= 'x;
        dut_vif.drv_cb.i_frame      <= 'x;
        dut_vif.drv_cb.i_valid      <= 'x;
        dut_vif.drv_cb.i_data       <= 'x;
        phase.drop_objection(this);

    endtask

    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info("CompDrv", "RESET_PHASE START", UVM_MEDIUM)

        phase.raise_objection(this);
        dut_vif.drv_cb.i_frame      <= '0;
        dut_vif.drv_cb.i_valid      <= '0;
        dut_vif.drv_cb.i_data       <= '0;

        dut_vif.drv_cb.reset_n      <= '0;
        repeat(10) @(dut_vif.drv_cb);
        dut_vif.drv_cb.reset_n      <= '1;
        repeat(10) @(dut_vif.drv_cb);

        phase.drop_objection(this);
        `uvm_info("CompDrv", "RESET_PHASE END", UVM_MEDIUM)

    endtask


    virtual task run_phase(uvm_phase phase);

        logic [7:0] tmp;

        repeat(30) @(dut_vif.drv_cb);

        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("CompDrv", {"\n", req.sprint()}, UVM_MEDIUM)

            dut_vif.drv_cb.i_frame[req.src_addr] <= 1'b1;

            for (int i = 0; i < 4; i++) begin
                dut_vif.drv_cb.i_data[req.src_addr] <= req.dst_addr[i];
                @(dut_vif.drv_cb);
            end

            repeat(pad_cycles) @(dut_vif.drv_cb);

            while(dut_vif.drv_cb.o_busy[req.src_addr]) begin
                @(dut_vif.drv_cb);
            end

            foreach(req.payload[i]) begin
                tmp = req.payload[i];
                for (int j = 0; j < 8; j++) begin
                    dut_vif.drv_cb.i_data[req.src_addr] <= tmp[j];
                    dut_vif.drv_cb.i_valid[req.src_addr] <= 1'b1;
                    @(dut_vif.drv_cb);
                end
            end

            dut_vif.drv_cb.i_frame[req.src_addr] <= 1'b0;

            seq_item_port.item_done();
        end
    endtask

endclass