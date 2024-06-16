class AxiMasterDrv extends uvm_driver #(TrAxi);

    /* Factory Register this Class */
    `uvm_component_utils(AxiMasterDrv)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfAxi vifAxi;

    /* Constructor Func */
    function new(string name = "AxiMasterDrv", uvm_component parent);
        super.new(name, parent);
        /* Create Object Space */
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfAxi)::get(this, "", "vifAxi", vifAxi))
            `uvm_fatal("NOVIF", "No IfAxi Interface Specified")        
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        {vifAxi.awid, vifAxi.awaddr, vifAxi.awlen, vifAxi.awsize, vifAxi.awburst, vifAxi.awlock, vifAxi.awcache, vifAxi.awprot, vifAxi.awvalid} = '{default:0};
        {vifAxi.wdata, vifAxi.wstrb, vifAxi.wlast, vifAxi.wvalid} = '{default:0};
        {vifAxi.bready} = '{default:0};
        {vifAxi.arid, vifAxi.araddr, vifAxi.arlen, vifAxi.arsize, vifAxi.arburst, vifAxi.arlock, vifAxi.arcache, vifAxi.arprot, vifAxi.arvalid} = '{default:0};
        {vifAxi.rready} = '{default:0};

        vifAxi.aresetn = 0;
        #200;
        vifAxi.aresetn = 1;
        #200;

        phase.drop_objection(this);
    endtask

    virtual task aw_channel(TrAxi req);
        vifAxi.m_cb.awid    <= req.id;
        vifAxi.m_cb.awaddr  <= req.addr;
        vifAxi.m_cb.awlen   <= req.len;
        vifAxi.m_cb.awsize  <= req.size;
        vifAxi.m_cb.awburst <= req.burst;
        vifAxi.m_cb.awlock  <= req.lock;
        vifAxi.m_cb.awcache <= req.cache;
        vifAxi.m_cb.awprot  <= req.prot;
        vifAxi.m_cb.awvalid <= 1;
        @(vifAxi.m_cb);

        while (!vifAxi.m_cb.awready) @(vifAxi.m_cb);

        vifAxi.m_cb.awvalid <= 0;

    endtask

    virtual task w_channel(TrAxi req);

        for (int i = 0; i < req.data.size(); i++) begin
            vifAxi.m_cb.wvalid <= 1;
            while (!vifAxi.m_cb.wready) @(vifAxi.m_cb);
            vifAxi.m_cb.wdata  <= req.data[i];
            vifAxi.m_cb.wstrb  <= req.strb[i];
            if (i == req.data.size() - 1) vifAxi.m_cb.wlast  <= 1;            
            @(vifAxi.m_cb);
        end

        vifAxi.m_cb.wlast  <= 0;
        vifAxi.m_cb.wvalid <= 0;
    endtask

    virtual task b_channel(TrAxi req);
        while (!vifAxi.m_cb.bvalid) @(vifAxi.m_cb);
        req.id = vifAxi.m_cb.bid;
        req.resp = vifAxi.m_cb.bresp;
        vifAxi.m_cb.bready <= 1;
        @(vifAxi.m_cb);
        vifAxi.m_cb.bready <= 0;
    endtask

    virtual task run_phase(uvm_phase phase);

        wait(vifAxi.aresetn);
        repeat (10) @(vifAxi.m_cb);

        forever begin
            seq_item_port.get_next_item(req);

            @(vifAxi.m_cb);

            $display(req.my_print());

            aw_channel(req);
            repeat(10) @(vifAxi.m_cb);
            w_channel(req);
            repeat(10) @(vifAxi.m_cb);
            b_channel(req);

            repeat(10) @(vifAxi.m_cb);

            seq_item_port.item_done();
        end

    endtask

endclass