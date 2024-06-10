class DrvApb extends uvm_driver #(TrApb);

    /* Factory Register this Class */
    `uvm_component_utils(DrvApb)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfApb vifApb;

    /* Constructor Func */
    function new(string name = "DrvApb", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfApb)::get(this, "", "vifApb", vifApb))
            `uvm_fatal("NO_IFAPB", "No IfApb Interface Specified")

        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual task pre_reset_phase(uvm_phase phase);        
        phase.raise_objection(this);
        vifApb.drv_cb.presetn   <= 'x;
        vifApb.drv_cb.paddr     <= 'x;
        vifApb.drv_cb.pwdata    <= 'x;
        vifApb.drv_cb.pwrite    <= 'x;
        vifApb.drv_cb.psel      <= 'x;
        vifApb.drv_cb.penable   <= 'x;

        repeat(3) @(vifApb.drv_cb);
        phase.drop_objection(this);
    endtask

    virtual task reset_phase(uvm_phase phase);        
        phase.raise_objection(this);
        vifApb.drv_cb.paddr     <= '0;
        vifApb.drv_cb.pwdata    <= '0;
        vifApb.drv_cb.pwrite    <= '0;
        vifApb.drv_cb.psel      <= '0;
        vifApb.drv_cb.penable   <= '0;

        vifApb.drv_cb.presetn   <= '0;
        repeat(3) @(vifApb.drv_cb);
        vifApb.drv_cb.presetn   <= '1;
        repeat(3) @(vifApb.drv_cb);

        phase.drop_objection(this);
    endtask

    virtual task drv_data(TrApb req, int delay);

        // `uvm_info("drv_data", {req.my_print(), ", delay = ", $sformatf("%0d", delay)}, UVM_MEDIUM)
        `uvm_info("drv_data", $sformatf("%s, delay = %0d", req.my_print(), delay), UVM_MEDIUM)

        vifApb.drv_cb.paddr     <= req.addr;
        if (req.write)
            vifApb.drv_cb.pwdata    <= req.data;
        vifApb.drv_cb.pwrite    <= req.write;

        vifApb.drv_cb.psel      <= 1;
        vifApb.drv_cb.penable   <= 0;
        @(vifApb.drv_cb);
        vifApb.drv_cb.penable   <= 1;
        @(vifApb.drv_cb);

        while (vifApb.drv_cb.pready == 0) @(vifApb.drv_cb);
        vifApb.drv_cb.psel      <= 0;
        vifApb.drv_cb.penable   <= 0;

        // extra delay
        repeat(delay) @(vifApb.drv_cb);
    endtask

    virtual task run_phase(uvm_phase phase);
        int delay;

        repeat(10) @(vifApb.drv_cb);
        `uvm_info("run_phase", "run_phase", UVM_MEDIUM)

        forever begin
            seq_item_port.get_next_item(req);

            delay = $urandom_range(0, 7);

            this.drv_data(req, $urandom_range(0, 7));

            rsp = TrApb::type_id::create("rsp");
            $cast(rsp, req.my_clone);
            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);

            seq_item_port.item_done();
        end

    endtask

endclass