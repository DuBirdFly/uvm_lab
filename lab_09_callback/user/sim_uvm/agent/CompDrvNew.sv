class CompDrvNew extends CompDrv;

    /* 声明变量 */

    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_component_utils(CompDrvNew)

    /* 构造函数 */
    function new(string name = "CompDrvNew", uvm_component parent);
        super.new(name, parent);
        `uvm_info("new", "Override new", UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);

        repeat(30) @(vif_dut.drv_cb);

        forever begin
            seq_item_port.get_next_item(req);
            req.payload.push_back(8'hff);

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
