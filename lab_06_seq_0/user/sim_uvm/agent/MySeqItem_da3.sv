class MySeqItem_da3 extends MySeqItem;

    /* �������� */
    
    /* ��������ľ�� */

    /* ע����� */
    `uvm_object_utils(MySeqItem_da3)

    /* Լ�� */
    constraint c_dst_addr { dst_addr == 3; }

    /* ���캯�� */
    function new(string name = "MySeqItem_da3");
        super.new(name);
        `uvm_info(get_type_name(), "Override new func", UVM_MEDIUM)
        /* new() �������ٶ���ռ�*/
    endfunction

endclass
