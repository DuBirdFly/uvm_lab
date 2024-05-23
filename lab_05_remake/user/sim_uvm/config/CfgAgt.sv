class CfgAgt extend uvm_object;

    /* 声明变量 */
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    int unsigned pad_cycle = 5;
    virtual IntfDut intf_dut;

    /* 注册对象 */
    `uvm_object_utils_begin(CfgAgt)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ACTIVE)
        `uvm_field_int(pad_cycle, UVM_ALL_ON)
    `uvm_object_utils_end

    /* 构造函数 */
    function new(string name = "CfgAgt");
        super.new(name);
        /* new() 函数开辟对象空间*/
    endfunction

endclass