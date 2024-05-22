class my_environment extends uvm_env;

    `uvm_component_utils(my_environment)

    master_agent m_agent;

    env_config m_env_cfg;

    function new(string name = "my_environment", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        m_agent = master_agent::type_id::create("m_agent", this);

        if (!uvm_config_db#(env_config)::get(this, "", "env_cfg", m_env_cfg))
            `uvm_fatal("NO_ENV_CFG", "ENV can not get the configuration")

        uvm_config_db#(agent_config)::set(this, "m_agent", "m_agent_cfg", m_env_cfg.m_agent_cfg);

        if (m_env_cfg.is_coverage) `uvm_info("COVERAGE", "Coverage is enabled", UVM_MEDIUM)

        if (m_env_cfg.is_check) `uvm_info("CHECK", "Check is enabled", UVM_MEDIUM)

    endfunction

endclass
