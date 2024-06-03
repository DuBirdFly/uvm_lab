class CfgEnv extends uvm_object;
    /* 声明变量 */
    int is_coverage = 0;    // 代码覆盖率
    int is_check = 0;       // 是否有 scoreboard

    /* 创建对象的句柄 */
    CfgAgt cfgAgt;

    /* 注册对象 */
    `uvm_object_utils_begin(CfgEnv)
        `uvm_field_int(is_coverage, UVM_ALL_ON)
        `uvm_field_int(is_check, UVM_ALL_ON)
        `uvm_field_object(cfgAgt, UVM_ALL_ON)
    `uvm_object_utils_end

    /* 构造函数 */
    function new(string name = "CfgEnv");
        super.new(name);

        /* new() 函数开辟对象空间*/
        cfgAgt = new("cfgAgt");
    endfunction

endclass