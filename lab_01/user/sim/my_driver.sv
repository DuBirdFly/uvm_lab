class my_driver extends uvm_driver #(my_transaction);

    // If it's a UVM component(组件), it should have a "`uvm_component_utils" macro
    // Else you should have a "`uvm_object_utils" macro
    `uvm_component_utils(my_driver)

    // Note: you should specify the parent class of the driver --> uvm_component parent
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // The main task of the driver
    // - Get transactions from the sequencer
    // - Split the transactions into bits and send them to the DUT
    virtual task run_phase(uvm_phase phase);
        // Usually, the driver will run FOREVER
        forever begin
            // Get transactions from the sequencer, get one each time
            seq_item_port.get_next_item(req);
            #100;
            // Print the transaction which just get
            `uvm_info("DRV_RUN_PHASE", req.sprint(), UVM_MEDIUM)
            // Split the transaction into bits and send them to the DUT
            // ...
            // ...
            // Feedback to the sequencer that the transaction is done
            seq_item_port.item_done();
        end
    endtask
endclass
