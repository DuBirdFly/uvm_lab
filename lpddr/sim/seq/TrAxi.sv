// `define LOOP(Len, code) \
// for (int i = 0; i < Len; i++) begin \
//     code \
// end \

class TrAxi extends uvm_sequence_item;
    
    /* Factory Register this Class */
    `uvm_object_utils(TrAxi)

    /* Declare Normal Variables */
    bit [`AXI_STRB_WIDTH - 1:0] align_mask [$];
    bit [`AXI_STRB_WIDTH - 1:0] align_strb [$];

    /* Declare Random Variables */
    rand bit [`AXI_ID_WIDTH - 1:0]     id;
    rand bit [`AXI_ADDR_WIDTH - 1:0]   addr;
    rand bit [`AXI_LEN_WIDTH - 1:0]    len;
    rand bit [`AXI_SIZE_WIDTH - 1:0]   size;
    rand bit [`AXI_BURST_WIDTH - 1:0]  burst;
    rand bit                           lock;
    rand bit [`AXI_CACHE_WIDTH - 1:0]  cache;
    rand bit [`AXI_PROT_WIDTH - 1:0]   prot;
    rand bit [`AXI_DATA_WIDTH - 1:0]   data[$];
    rand bit [`AXI_STRB_WIDTH - 1:0]   strb[$];
    bit      [`AXI_RESP_WIDTH - 1:0]   resp;

    /* constraints */
    constraint c_base {
        id == 0;
        addr <= 2 ** `AXI_ADDR_WIDTH - `AXI_STRB_WIDTH * len;
        len inside {[0:3]};
        // size <= $clog2(`AXI_STRB_WIDTH);
        size == 4;
        burst == 1;
        lock == 0;
        cache == 0;
        prot == 0;
        data.size() == len + 1;
        strb.size() == len + 1;
    }

    virtual function void align_calcu();
        align_mask.delete();
        align_strb.delete();

        // Initialize align_mask, align_strb
        repeat (len + 1) align_mask.push_back('0);
        repeat (len + 1) align_strb.push_back('0);

        // 根据 addr 生成对齐情况下的第一个 align_mask
        for (int i = 0; i < 2 ** size; i++) align_mask[0][i] = 1'b1;
        align_mask[0] = align_mask[0] << ((addr % `AXI_STRB_WIDTH) / (2 ** size) * (2 ** size));

        // 循环左移以生成剩下的 align_mask
        for (int i = 1; i <= len; i++) begin
            bit [`AXI_STRB_WIDTH - 1:0] tmp;
            align_mask[i] = align_mask[i - 1];

            repeat(2 ** size) align_mask[i] = {align_mask[i][`AXI_STRB_WIDTH - 2:0], align_mask[i][`AXI_STRB_WIDTH - 1]};
        end

        // 处理第一个 align_mask 的非对齐情况
        for (int i = 0; i < addr % `AXI_STRB_WIDTH; i++) align_mask[0][i] = 1'b0;

        // 根据 align_mask[$], strb[$] 生成 align_strb[$]
        for (int i = 0; i <= len; i++) align_strb[i] = strb[i] & align_mask[i];

    endfunction

    virtual function string get_info();
        string str = "";
        str = {str, $sformatf("======================= time = %0t ========================\n", $realtime)};
        str = {str, $sformatf("id = %0d, addr = 0x%0H, len = %0d(+1), size = %0d (%0d byte)\n", id, addr, len, size, 2**size)};
        str = {str, $sformatf("burst = %b, lock = %b, cache = %b, prot = %b. resp = %0d\n", burst, lock, cache, prot, resp)};

        for (int i = 0; i <= len; i++) begin
            str = {str, $sformatf("[%4d] 0x%h, %b - %b - %b\n", i, data[i], strb[i], align_mask[i], align_strb[i])};
        end

        return str;
    endfunction

endclass
