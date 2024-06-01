class CfgEnv extends uvm_object;
    /* �������� */
    int is_coverage = 0;    // ���븲����
    int is_check = 0;       // �Ƿ��� scoreboard

    /* ��������ľ�� */
    CfgAgt cfgAgt;

    /* ע����� */
    `uvm_object_utils_begin(CfgEnv)
        `uvm_field_int(is_coverage, UVM_ALL_ON)
        `uvm_field_int(is_check, UVM_ALL_ON)
        `uvm_field_object(cfgAgt, UVM_ALL_ON)
    `uvm_object_utils_end

    /* ���캯�� */
    function new(string name = "CfgEnv");
        super.new(name);

        /* new() �������ٶ���ռ�*/
        cfgAgt = new("cfgAgt");
    endfunction

endclass