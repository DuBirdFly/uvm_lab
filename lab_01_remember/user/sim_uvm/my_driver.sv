/*
(1) The driver class is extends from uvm_driver
    1. The transaction class is passed as a parameter to the driver class
(2) Register class-name in the factory with MACRO `uvm_component_utils(class-name)
(3) Override a 'constructor' function: new (string name, uvm_component parent)
(4) Override a 'run_phase' task
    1. Usually, run FOREVER
    2. Get transactions from the sequencer
        - seq_item_port.get_next_item(req)   --> Get transactions from the Sequencer
        - Split the transaction into bits and send them to the DUT
        - seq_item_port.item_done()          --> Feedback to the Sequencer that the transaction is done
*/

class my_driver extends uvm_driver #(my_transaction);

    `uvm_component_utils(my_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);   // "req" is a handle to the transaction
            #100;
            `uvm_info("DRV_RUN_PHASE", {"\n", req.sprint()}, UVM_MEDIUM)
            seq_item_port.item_done();
        end
    endtask

endclass
