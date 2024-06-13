class ApbSeqRand extends uvm_sequence #(TrApb);

    /* Factory Register this Class */
    `uvm_object_utils(ApbSeqRand)

    /* Declare Normal Variables */
    int tr_num = 0;

    /* Declare Object Handles */

    /* Constructor Func */
    function new(string name = "ApbSeqRand");
        super.new(name);
        /* Create Object Space */
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        if (tr_num == 0) `uvm_error("TR_NUM", "tr_num is 0, please set tr_num in Test.sv")
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
