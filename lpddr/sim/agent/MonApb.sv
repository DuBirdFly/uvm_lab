class MonApb extends uvm_monitor;

    /* Factory Register this Class */
    `uvm_component_utils(MonApb)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfApb vifApb;
    uvm_blocking_put_port #(TrApb) put_port = new("put_port", this);

    /* Constructor Func */
    function new(string name = "MonApb", uvm_component parent);
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

    virtual task run_phase(uvm_phase phase);
        forever begin
            TrApb trApb = TrApb::type_id::create("trApb", this);

            wait (vifApb.mon_cb.psel & vifApb.mon_cb.penable & vifApb.mon_cb.pready);

            trApb.addr  = vifApb.mon_cb.paddr;
            trApb.write = vifApb.mon_cb.pwrite;

            if (vifApb.mon_cb.pwrite) trApb.data = vifApb.mon_cb.pwdata;
            else                      trApb.data = vifApb.mon_cb.prdata;

            @(vifApb.mon_cb);

            put_port.put(trApb);
        end
    endtask

endclass