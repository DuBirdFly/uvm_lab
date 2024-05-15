/*
 * 1. Class sequence should be extended from uvm_sequence
 * 2. Class sequence control and create a sequence of transactions
 * 3. Normally, One Type of sequence class creates one type of transaction
 * 4. Class sequence class should have a body() method to control the sequence of transactions
 */

// "#" means the sequence creates a specific transaction type "my_transaction"
class my_sequence extends uvm_sequence #(my_transaction);

    // Define the `uvm_object_utils macro to enable the factory and print methods
    `uvm_object_utils(my_sequence)

    // Define the constructor
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    // Define the body of the sequence
    virtual task body();
        // Control when to start the verification platform
        if (starting_phase != null) starting_phase.raise_objection(this);
        // Create 3 transactions, "req" is a handle to the transaction
        repeat(3) `uvm_do(req)
        #100;
        // Control when to stop the verification platform
        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass

/*
 * 1. The role of the "sequencer" is to initiate the "sequence"
 * 2. Sequencer can send item ("item" is created by sequence) to the driver
 */
typedef uvm_sequencer #(my_transaction) my_sequencer;
