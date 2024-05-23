class CompMon extends uvm_monitor;


    /* 声明变量 */

    /* 创建对象的句柄 */

    /* 注册对象 */
    `uvm_component_utils(CompMon)

    /* 构造函数 */
    function new(string name = "CompMon", uvm_component parent);
        super.new(name, parent);
        /* new() 函数开辟对象空间*/
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