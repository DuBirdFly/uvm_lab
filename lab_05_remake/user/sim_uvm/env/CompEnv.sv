class CompEnv extends uvm_env;


    /* 声明变量 */

    /* 创建对象的句柄 */
    CompAgtMstr compAgtMstr;

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

        /* uvm_config_db::set() */

        /* type_id::create() 函数开辟 Comp 组件对象空间 */
        compAgtMstr = CompAgtMstr::type_id::create("compAgtMstr", this);

    endfunction

endclass