class MySeq extends uvm_sequence #(MySeqItem);

    /* �������� */
    int item_num = 1;

    /* ��������ľ�� */

    /* ע����� */
    `uvm_object_utils(MySeq)

    /* ���캯�� */
    function new(string name = "MySeq");
        super.new(name);
        /* new() �������ٶ���ռ�*/
    endfunction

    function void pre_randomize();
        // ǿ���޸� rand_mode ���̶�ֵ, "m_sequencer" ��Ĭ�ϵ� sequencer ���
        if (!uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num))
            `uvm_fatal("MySeq", "NOT GET ITEM_NUM")
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);

        repeat(item_num) `uvm_do(req);
        #100;

        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

endclass
