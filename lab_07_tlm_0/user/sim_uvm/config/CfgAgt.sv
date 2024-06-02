class CfgAgt extends uvm_object;

    /* �������� */
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    int unsigned pad_cycle = 5;

    /* ��������ľ�� */
    virtual IntfDut vif_dut;

    /* ע����� */
    `uvm_object_utils_begin(CfgAgt)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ACTIVE)
        `uvm_field_int(pad_cycle, UVM_ALL_ON)
    `uvm_object_utils_end

    /* ���캯�� */
    function new(string name = "CfgAgt");
        super.new(name);
        /* new() �������ٶ���ռ�*/
    endfunction

endclass