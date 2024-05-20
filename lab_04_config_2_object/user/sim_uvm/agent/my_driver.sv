class my_driver extends uvm_driver #(my_transaction);

    `uvm_component_utils(my_driver)

    virtual dut_interface m_vif;

    function new(string name = "my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (uvm_config_db #(virtual dut_interface)::get(this, "*", "vif", m_vif))
            `uvm_info("DRV_BUILD_PHASE", "Driver 获取到接口", UVM_MEDIUM)
        else
            `uvm_error("DRV_BUILD_PHASE", "Driver 未获取到接口")
    endfunction

    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("DRV_PRE_RESET_PHASE", "Driver 正在 Pre-Reset", UVM_MEDIUM)

        phase.raise_objection(this);    
        m_vif.drv_cb.reset_n     <= 'x;
        m_vif.drv_cb.i_frame     <= 'x;
        m_vif.drv_cb.i_valid     <= 'x;
        m_vif.drv_cb.i_data      <= 'x;
        phase.drop_objection(this);

        `uvm_info("DRV_PRE_RESET_PHASE", "Driver Pre-Reset 完成", UVM_MEDIUM)
    endtask

    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info("DRV_RESET_PHASE", "Driver 正在 Reset", UVM_MEDIUM)

        phase.raise_objection(this);
        m_vif.drv_cb.i_frame     <= '0;
        m_vif.drv_cb.i_valid     <= '0;
        m_vif.drv_cb.i_data      <= '0;

        m_vif.drv_cb.reset_n     <= '0;
        repeat(10) @(m_vif.drv_cb);
        m_vif.drv_cb.reset_n     <= '1;
        repeat(10) @(m_vif.drv_cb);

        phase.drop_objection(this);
        `uvm_info("DRV_RESET_PHASE", "Driver Reset 完成", UVM_MEDIUM)
    endtask

    virtual task run_phase(uvm_phase phase);
        logic [7:0] tmp;
        int delay_count;

        repeat(30) @(m_vif.drv_cb);

        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("DRV_MAIN_PHASE", {"\n", req.sprint()}, UVM_MEDIUM)

            m_vif.drv_cb.i_frame[req.src_addr] <= 1'b1;

            for (int i = 0; i < 4; i++) begin
                m_vif.drv_cb.i_data[req.src_addr] <= req.dst_addr[i];
                @(m_vif.drv_cb);
            end

            delay_count = $urandom_range(0, 5);
            repeat(delay_count) @(m_vif.drv_cb);

            while(!m_vif.drv_cb.o_busy[req.src_addr]) @(m_vif.drv_cb);

            foreach(req.payload[i]) begin
                tmp = req.payload[i];
                for (int j = 0; j < 8; j++) begin
                    m_vif.drv_cb.i_data[req.src_addr] <= tmp[j];
                    m_vif.drv_cb.i_valid[req.src_addr] <= 1'b1;
                    @(m_vif.drv_cb);
                end
            end

            m_vif.drv_cb.i_frame[req.src_addr] <= 1'b0;

            seq_item_port.item_done();
        end
    endtask

endclass
