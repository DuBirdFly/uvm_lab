class CompEnv extends uvm_env;

    /* 声明变量 */

    /* 创建对象的句柄 */
    CompAgtMstr compAgtMstr;

    CfgEnv cfgEnv;

    /* 注册对象 */
    `uvm_component_utils(CompEnv)

    /* 构造函数 */
    function new(string name = "CompEnv", uvm_component parent);
        super.new(name, parent);
        
        /* new() 函数开辟对象空间*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgEnv)::get(this, "", "cfgEnv", cfgEnv))
            `uvm_fatal("CompEnv", "CfgEnv not found")

        /* uvm_config_db::set() */
        uvm_config_db#(CfgAgt)::set(this, "compAgtMstr", "cfgAgt", cfgEnv.cfgAgt);

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compAgtMstr = CompAgtMstr::type_id::create("compAgtMstr", this);

        /* User Code*/
        if (cfgEnv.is_coverage) `uvm_info("build_phase", "Coverage is enabled", UVM_MEDIUM)
        if (cfgEnv.is_check) `uvm_info("build_phase", "ScoreBoard for check is enabled", UVM_MEDIUM)

    endfunction

endclass