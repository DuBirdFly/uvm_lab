class SeqApbRand extends uvm_sequence #(TrApb);

    /* Factory Register this Class */
    `uvm_object_utils(SeqApbRand)

    /* Declare Normal Variables */
    int tr_num = 3;

    /* Declare Object Handles */

    /* Constructor Func */
    function new(string name = "SeqApbRand");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(tr_num) begin
            TrApb tr = TrApb::type_id::create("tr");

            start_item(tr);
            if (!tr.randomize()) `uvm_error("RANDOMIZE", "Failed to randomize transaction")
            finish_item(tr);

            get_response(rsp);
        end

        if (starting_phase != null) starting_phase.drop_objection(this);

    endtask

endclass
