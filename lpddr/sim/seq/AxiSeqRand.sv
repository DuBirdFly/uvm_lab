class AxiSeqRand extends uvm_sequence #(TrAxi);

    /* Factory Register this Class */
    `uvm_object_utils(AxiSeqRand)

    /* Declare Normal Variables */
    int tr_num = 8;

    /* Declare Object Handles */

    /* Constructor Func */
    function new(string name = "AxiSeqRand");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual task body();
        TrAxi tr;
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(tr_num) begin
            tr = TrAxi::type_id::create("tr");
            tr.pre_rand();
            if (!tr.randomize()) `uvm_error("RANDOMIZE", "Failed to randomize transaction")

            start_item(tr);
            finish_item(tr);

        end

        if (starting_phase != null) starting_phase.drop_objection(this);
    
    endtask

endclass