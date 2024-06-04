class CompOMon extends uvm_monitor;
    /* 声明变量 */

    /* 创建对象的句柄 */
    virtual IntfDut vif_dut;
    //!uvm_blocking_put_port #(MySeqItem) omon2sagt_port;

    /* 注册对象 */
    `uvm_component_utils(CompOMon)

    /* 构造函数 */
    function new(string name = "CompOMon", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db#(virtual IntfDut)::get(this, "", "vif_dut", vif_dut))
            `uvm_fatal("build_phase", "NOT GET INTERFACE")

        /* uvm_config_db::set() */

    endfunction

    virtual task run_phase(uvm_phase phase);
        MySeqItem   tr;       // transaction
        logic [7:0] tmp;
        int         cnt;
        string      msg;

        forever begin
            tr = MySeqItem::type_id::create("tr");
            cnt = 0;

            wait (|vif_dut.mon_out_cb.o_valid);

            case (vif_dut.mon_out_cb.o_valid)
                4'b0001: tr.dst_addr = 0;
                4'b0010: tr.dst_addr = 1;
                4'b0100: tr.dst_addr = 2;
                4'b1000: tr.dst_addr = 3;
                default: begin
                    $sformat(msg, "Invalid o_valid = %4b", vif_dut.mon_out_cb.o_valid);
                    `uvm_error("run_phase", msg)
                end
            endcase

            forever begin
                if (~vif_dut.mon_out_cb.o_valid[tr.dst_addr]) begin
                    if (cnt != 0) begin
                        $sformat(msg, "Invalid cnt = %0d when o_valid = 0", cnt);
                        `uvm_error("run_phase", msg)
                    end
                    break;
                end

                if (vif_dut.mon_out_cb.o_valid[tr.dst_addr]) begin
                    tmp[cnt] = vif_dut.mon_out_cb.o_data[tr.dst_addr];

                    if (cnt++ == 7) begin
                        cnt = 0;
                        tr.payload.push_back(tmp);
                    end
                end

                @(vif_dut.mon_out_cb);
            end

            `uvm_info("run_phase", {"OMon Catched a MySeqItem from vif (src_addr is invalid), ", tr.my_sprint()}, UVM_MEDIUM)
            //!omon2sagt_port.put(tr);
        end

    endtask

endclass