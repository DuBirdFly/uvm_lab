class CompEnv extends uvm_env;

    /* �������� */

    /* ��������ľ�� */
    CompAgtMstr compAgtMstr;

    CfgEnv cfgEnv;

    /* ע����� */
    `uvm_component_utils(CompEnv)

    /* ���캯�� */
    function new(string name = "CompEnv", uvm_component parent);
        super.new(name, parent);
        
        /* new() �������ٶ���ռ�*/
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /* uvm_config_db::get() */
        if (!uvm_config_db #(CfgEnv)::get(this, "", "cfgEnv", cfgEnv))
            `uvm_fatal("CompEnv", "CfgEnv not found")

        /* uvm_config_db::set() */
        uvm_config_db#(CfgAgt)::set(this, "compAgtMstr", "cfgAgt", cfgEnv.cfgAgt);

        /* type_id::create() �������� Comp �������ռ� */
        compAgtMstr = CompAgtMstr::type_id::create("compAgtMstr", this);

        /* User Code*/
        if (cfgEnv.is_coverage) `uvm_info("build_phase", "Coverage is enabled", UVM_MEDIUM)
        if (cfgEnv.is_check) `uvm_info("build_phase", "ScoreBoard for check is enabled", UVM_MEDIUM)

    endfunction

endclass