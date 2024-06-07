class CompDrv extends uvm_driver #(MySeqItem);

    /* 声明变量 */
    int unsigned pad_cycle = 5;

    /* 创建对象的句柄 */
    virtual IntfDut vif_dut;

    /* 注册对象 */
    `uvm_component_utils(CompDrv)

    /* 构造函数 */
    function new(string name = "CompDrv", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual IntfDut)::get(this, "", "vif_dut", vif_dut))
            `uvm_fatal("CompDrv", "NOT GET INTERFACE")

        if (!uvm_config_db#(int unsigned)::get(this, "", "pad_cycle", pad_cycle))
            `uvm_fatal("CompDrv", "NOT GET PAD_CYCLE")

        /* uvm_config_db::set() */

    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("pre_reset_phase", "reset intferface to 'x", UVM_MEDIUM)

        phase.raise_objection(this);
        vif_dut.drv_cb.reset_n      <= 'x;
        vif_dut.drv_cb.i_frame      <= 'x;
        vif_dut.drv_cb.i_valid      <= 'x;
        vif_dut.drv_cb.i_data       <= 'x;
        repeat(2) @(vif_dut.drv_cb);
        phase.drop_objection(this);

    endtask

    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info("reset_phase", "reset intferface to '0/1", UVM_MEDIUM)

        phase.raise_objection(this);
        vif_dut.drv_cb.i_frame      <= '0;
        vif_dut.drv_cb.i_valid      <= '0;
        vif_dut.drv_cb.i_data       <= '0;

        vif_dut.drv_cb.reset_n      <= '0;
        repeat(5) @(vif_dut.drv_cb);
        vif_dut.drv_cb.reset_n      <= '1;
        repeat(5) @(vif_dut.drv_cb);

        phase.drop_objection(this);

    endtask

    virtual task send_req(MySeqItem req);
        vif_dut.drv_cb.i_frame[req.src_addr] <= 1'b1;

        for (int i = 0; i < 2; i++) begin
            vif_dut.drv_cb.i_data[req.src_addr] <= req.dst_addr[i];
            @(vif_dut.drv_cb);
        end

        repeat(pad_cycle) @(vif_dut.drv_cb);

        wait(vif_dut.drv_cb.o_grant[req.src_addr]);

        foreach(req.payload[i]) begin
            for (int j = 0; j < 8; j++) begin
                vif_dut.drv_cb.i_data[req.src_addr] <= req.payload[i][j];
                vif_dut.drv_cb.i_valid[req.src_addr] <= 1'b1;
                @(vif_dut.drv_cb);
            end
        end

        vif_dut.drv_cb.i_frame[req.src_addr] <= 1'b0;
        vif_dut.drv_cb.i_valid[req.src_addr] <= 1'b0;
        @(vif_dut.drv_cb);
    endtask

    virtual task run_phase(uvm_phase phase);

        repeat(30) @(vif_dut.drv_cb);

        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("run_phase", {"", req.my_sprint()}, UVM_MEDIUM)

            this.send_req(req);

            rsp = MySeqItem::type_id::create("rsp");
            $cast(rsp, req.clone());
            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);

            seq_item_port.item_done();
        end
    endtask

endclass