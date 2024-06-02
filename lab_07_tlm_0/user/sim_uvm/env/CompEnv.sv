class CompEnv extends uvm_env;

    /* �������� */

    /* ��������ľ�� */
    CompAgtMstr compAgtMstr;
    CompRefModel compRefModel;

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
        compRefModel = CompRefModel::type_id::create("compRefModel", this);

        /* User Code*/
        if (cfgEnv.is_coverage) `uvm_info("build_phase", "Coverage is enabled", UVM_MEDIUM)
        if (cfgEnv.is_check) `uvm_info("build_phase", "ScoreBoard for check is enabled", UVM_MEDIUM)

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("DBG: CompEnv connect_phase");
        `uvm_info("connect_phase", "connect CompAgtMstr and CompRefModel", UVM_MEDIUM)
        compAgtMstr.magt2ref_export.connect(compRefModel.imon2ref_imp);
    endfunction

endclass