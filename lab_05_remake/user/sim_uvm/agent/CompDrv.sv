class CompDrv extends uvm_driver #(MySeqItem);

    /* 声明变量 */
    int unsigned pad_cycles = 5;

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
        if (!uvm_config_db#(virtual IntfDut)::get(this, "*", "vif_dut", vif_dut))
            `uvm_fatal("CompDrv", "NOT GET INTERFACE")

        /* uvm_config_db::set() */

    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("CompDrv", "PRE_RESET_PHASE START", UVM_MEDIUM)

        phase.raise_objection(this);    
        vif_dut.drv_cb.reset_n      <= 'x;
        vif_dut.drv_cb.i_frame      <= 'x;
        vif_dut.drv_cb.i_valid      <= 'x;
        vif_dut.drv_cb.i_data       <= 'x;
        phase.drop_objection(this);

    endtask

    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info("CompDrv", "RESET_PHASE START", UVM_MEDIUM)

        phase.raise_objection(this);
        vif_dut.drv_cb.i_frame      <= '0;
        vif_dut.drv_cb.i_valid      <= '0;
        vif_dut.drv_cb.i_data       <= '0;

        vif_dut.drv_cb.reset_n      <= '0;
        repeat(10) @(vif_dut.drv_cb);
        vif_dut.drv_cb.reset_n      <= '1;
        repeat(10) @(vif_dut.drv_cb);

        phase.drop_objection(this);
        `uvm_info("CompDrv", "RESET_PHASE END", UVM_MEDIUM)

    endtask


    virtual task run_phase(uvm_phase phase);

        logic [7:0] tmp;

        repeat(30) @(vif_dut.drv_cb);

        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("CompDrv", {"\n", req.sprint()}, UVM_MEDIUM)

            vif_dut.drv_cb.i_frame[req.src_addr] <= 1'b1;

            for (int i = 0; i < 4; i++) begin
                vif_dut.drv_cb.i_data[req.src_addr] <= req.dst_addr[i];
                @(vif_dut.drv_cb);
            end

            repeat(pad_cycles) @(vif_dut.drv_cb);

            while(vif_dut.drv_cb.o_busy[req.src_addr]) begin
                @(vif_dut.drv_cb);
            end

            foreach(req.payload[i]) begin
                tmp = req.payload[i];
                for (int j = 0; j < 8; j++) begin
                    vif_dut.drv_cb.i_data[req.src_addr] <= tmp[j];
                    vif_dut.drv_cb.i_valid[req.src_addr] <= 1'b1;
                    @(vif_dut.drv_cb);
                end
            end

            vif_dut.drv_cb.i_frame[req.src_addr] <= 1'b0;

            seq_item_port.item_done();
        end
    endtask

endclass