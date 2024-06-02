class CompRefModel extends uvm_component;

    /* �������� */

    /* ��������ľ�� */
    // ��Ϊ RefModel �� SeqItem �������ߣ����� RefModel ��Ҫһ�� SeqItem ������˿� (import = *_imp)
    uvm_blocking_put_imp#(MySeqItem, CompRefModel) imon2ref_imp;   // imonitor_to_refmodel_import

    /* ע����� */
    `uvm_component_utils(CompRefModel)

    /* ���캯�� */
    function new(string name = "CompRefModel", uvm_component parent);
        super.new(name, parent);
        /* new() �������ٶ���ռ�*/
        this.imon2ref_imp = new("imon2ref_imp", this);
    endfunction

    task put (MySeqItem tr);
        `uvm_info("put", {"\nCompRefModel ���յ�һ�� MySeqItem, ����Ϊ\n", tr.sprint()}, UVM_MEDIUM)
    endtask

endclass