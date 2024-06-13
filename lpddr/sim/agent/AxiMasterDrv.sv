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

    virtual task run_phase(uvm_phase phase);

        wait(vifAxi.aresetn);
        repeat (10) @(vifAxi.m_cb);

        forever begin
            seq_item_port.get_next_item(req);

            $display(req.my_print());

            seq_item_port.item_done();
        end

    endtask


endclass