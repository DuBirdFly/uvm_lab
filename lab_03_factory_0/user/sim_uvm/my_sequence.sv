/*
(1) The sequence class is extends from uvm_sequence
    1. The transaction class is passed as a parameter to the sequence class
(2) Register class-name in the factory with MACRO `uvm_object_utils(class-name)`
(3) Override a 'body' task
    1. Control when to start/end the sequence
        - starting_phase.raise_objection(this)
        - starting_phase.drop_objection(this)
    2. Generate several transactions with "`uvm_do" macro
*/

class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    
    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(3) `uvm_do(req);     // "req" is a handle to the transaction
        #100;

        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass
