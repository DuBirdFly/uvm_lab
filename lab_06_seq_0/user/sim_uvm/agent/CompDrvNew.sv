class CompDrvNew extends CompDrv;

    /* �������� */

    /* ��������ľ�� */

    /* ע����� */
    `uvm_component_utils(CompDrvNew)

    /* ���캯�� */
    function new(string name = "CompDrvNew", uvm_component parent);
        super.new(name, parent);
        `uvm_info("new", "Override new", UVM_MEDIUM)
    endfunction

endclass
