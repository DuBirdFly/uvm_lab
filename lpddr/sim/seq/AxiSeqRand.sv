class AxiSeqRand extends uvm_sequence #(TrAxi);

    /* Factory Register this Class */
    `uvm_object_utils(AxiSeqRand)

    /* Declare Normal Variables */

    /* Declare Object Handles */

    /* Constructor Func */
    function new(string name = "AxiSeqRand");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(8) begin
            TrAxi tr = TrAxi::type_id::create("tr");
            if (!tr.randomize()) `uvm_error("RANDOMIZE", "Failed to randomize transaction")

            start_item(tr);
            finish_item(tr);

        end

        if (starting_phase != null) starting_phase.drop_objection(this);
    
    endtask

endclass