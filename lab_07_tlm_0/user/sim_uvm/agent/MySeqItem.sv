class MySeqItem extends uvm_sequence_item;

    /* �������� */
    rand bit [1:0] src_addr;
    rand bit [1:0] dst_addr;
    rand reg [7:0] payload [$];

    /* ��������ľ�� */

    /* ע����� */
    `uvm_object_utils_begin(MySeqItem)
        `uvm_field_int(src_addr, UVM_ALL_ON)
        `uvm_field_int(dst_addr, UVM_ALL_ON)
        `uvm_field_queue_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    /* Լ�� */
    constraint c_limit_var {
        src_addr inside {[0:3]};
        dst_addr inside {[0:3]};
        payload.size() inside {[1:8]};
    }

    /* ���캯�� */
    function new(string name = "MySeqItem");
        super.new(name);
        /* new() �������ٶ���ռ�*/
    endfunction

endclass
