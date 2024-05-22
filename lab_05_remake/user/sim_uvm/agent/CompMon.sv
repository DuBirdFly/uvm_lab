class CompMon extends uvm_monitor;

    `uvm_component_utils(CompMon)

    /* 变量声明 */

    /* 创建对象的句柄 */

    function new(string name = "CompMon", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        forever begin
            #100;
        end
    endtask

endclass