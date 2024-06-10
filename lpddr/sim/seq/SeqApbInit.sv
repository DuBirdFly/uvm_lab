class SeqApbInit extends uvm_sequence #(TrApb);

    /* Factory Register this Class */
    `uvm_object_utils(SeqApbInit)

    /* Declare Object Handles */

    /* Constructor Func */
    function new(string name = "SeqApbInit");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        for (int i = 0; i <= 'hf; i++) begin
            TrApb tr = TrApb::type_id::create($sformatf("tr_%0d", i));
            TrApb rsp;

            tr.set_item(i, i, 1);
            start_item(tr);
            finish_item(tr);

            get_response(rsp);
        end

        if (starting_phase != null) starting_phase.drop_objection(this);

    endtask

endclass
