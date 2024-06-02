class CompIMon extends uvm_monitor;

    /* 声明变量 */

    /* 创建对象的句柄 */
    virtual IntfDut vif_dut;
    uvm_blocking_put_port #(MySeqItem) imon2ref_port;   // imonitor_to_refmodel_port

    /* 注册对象 */
    `uvm_component_utils(CompIMon)

    /* 构造函数 */
    function new(string name = "CompIMon", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
        this.imon2ref_port = new("imon2ref_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info("build_phase", "BUILD PHASE", UVM_MEDIUM)

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual IntfDut)::get(this, "", "vif_dut", vif_dut))
            `uvm_fatal("CompIMon", "NOT GET INTERFACE")

        /* uvm_config_db::set() */

    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        MySeqItem   tr;       // transaction
        logic [7:0] tmp;
        int         cnt;
        string      msg;

        forever begin
            tr = MySeqItem::type_id::create("tr");
            cnt = 0;

            // Wait for the start of a transaction
            wait (|vif_dut.mon_in_cb.i_frame);
            case (vif_dut.mon_in_cb.i_frame)
                4'b0001: tr.src_addr = 0;
                4'b0010: tr.src_addr = 1;
                4'b0100: tr.src_addr = 2;
                4'b1000: tr.src_addr = 3;
                default: begin
                    $sformat(msg, "Invalid i_frame = %4b", vif_dut.mon_in_cb.i_frame);
                    `uvm_error("CompIMon", msg)
                end

            endcase

            // Get Dst Address
            for (int i = 0; i < 2; i++) begin
                @(vif_dut.mon_in_cb);
                tr.dst_addr[i] = vif_dut.mon_in_cb.i_data[tr.src_addr];
            end

            // Get Payload
            forever begin
                if (~vif_dut.mon_in_cb.i_frame[tr.src_addr]) begin
                    if (cnt != 0) begin
                        msg = $sformatf("Invalid cnt = %0d when i_frame gets low", cnt);
                        `uvm_warning("CompIMon", msg)
                    end
                    break;
                end

                if (vif_dut.mon_in_cb.i_valid[tr.src_addr]) begin
                    tmp[cnt] = vif_dut.mon_in_cb.i_data[tr.src_addr];

                    if (cnt++ == 7) begin
                        cnt = 0;
                        tr.payload.push_back(tmp);
                    end 
                end

                @(vif_dut.mon_in_cb);
            end

            `uvm_info("CompIMon", {"\nIMon Catched a MySeqItem from vif\n", tr.sprint()}, UVM_MEDIUM)
            `uvm_info("CompIMon", "Now IMon will send the MySeqItem to RefModel!", UVM_MEDIUM)
            this.imon2ref_port.put(tr);

        end

    endtask

endclass