// 对于五个通道之间的关系，AXI协议仅定义了下面的关系：
// 1. 写响应必须跟随写操作的最后一个传输。
// 2. 读数据必须紧跟读地址数据。

// 除了上述两点定义，AXI未定义其他任何通道间的关系，
// 那么对于通道间的握手信号先后顺序，必须按照特定的顺序操作，不然很容易引起接口上的dead-lock。

// AXI 的特点：
// 1. 多笔未完成交易
// 2. 乱序数据补全
// 3. 仅发布起始地址的基于突发的事务
// 4. 支持使用选通的非对齐数据传输
// 5. 同时读取和写入事务

interface IfAxi(
    input bit                       aclk
);

    // AXI interface
    logic                           aresetn;

    // Write address channel
    logic [`AXI_ID_WIDTH - 1:0]     awid;
    logic [`AXI_ADDR_WIDTH - 1:0]   awaddr;
    logic [`AXI_LEN_WIDTH - 1:0]    awlen;   // (awlen + 1) transfers, 最大 256 transfers
    logic [`AXI_SIZE_WIDTH - 1:0]   awsize;  // 2^(awsize-1) bytes/transfer, 最大 256 bytes/transfer
    logic [`AXI_BURST_WIDTH - 1:0]  awburst; // 00: FIXED, 01: INCR, 10:WRAP
    logic                           awlock;
    logic [`AXI_CACHE_WIDTH - 1:0]  awcache;
    logic [`AXI_PROT_WIDTH - 1:0]   awprot;
    logic                           awvalid;
    logic                           awready;

    // Write data channel
    logic [`AXI_DATA_WIDTH - 1:0]   wdata;
    logic [`AXI_STRB_WIDTH - 1:0]   wstrb;
    logic                           wlast;
    logic                           wvalid;
    logic                           wready;

    // Write response channel
    logic [`AXI_ID_WIDTH - 1:0]     bid;
    logic [`AXI_RESP_WIDTH - 1:0]   bresp;
    logic                           bvalid;
    logic                           bready;

    // Read address channel
    logic [`AXI_ID_WIDTH - 1:0]     arid;
    logic [`AXI_ADDR_WIDTH - 1:0]   araddr;
    logic [`AXI_LEN_WIDTH - 1:0]    arlen;
    logic [`AXI_SIZE_WIDTH - 1:0]   arsize;
    logic [`AXI_BURST_WIDTH - 1:0]  arburst;
    logic                           arlock;
    logic [`AXI_CACHE_WIDTH - 1:0]  arcache;
    logic [`AXI_PROT_WIDTH - 1:0]   arprot;
    logic                           arvalid;
    logic                           arready;

    // Read data channel
    logic [`AXI_ID_WIDTH - 1:0]     rid;
    logic [`AXI_DATA_WIDTH - 1:0]   rdata;
    logic [`AXI_BURST_WIDTH - 1:0]  rresp;
    logic                           rlast;
    logic                           rvalid;
    logic                           rready;

    // master clocking block
    clocking m_cb @(posedge aclk);
        default input #1 output #1;
        output aresetn;

        output awid, awaddr, awlen, awsize, awburst;
        output awlock, awcache, awprot;
        output awvalid;
        input  awready;

        output wdata, wstrb, wlast;
        output wvalid;
        input  wready;

        input  bid, bresp;
        input  bvalid;
        output bready;

        output arid, araddr, arlen, arsize, arburst;
        output arlock, arcache, arprot;
        output arvalid;
        input  arready;

        input  rid;
        input  rdata, rresp, rlast;
        input  rvalid;
        output rready;
    endclocking

    function void peek_mem();
        $display("\n================================ PEEK MEMORY ================================");
        for (int i = 0; i < 2**(`AXI_ADDR_WIDTH - $clog2(`AXI_STRB_WIDTH)); i++) begin
            logic [`AXI_DATA_WIDTH - 1:0] data;
            data = Top.u_lpddr_ctrl.u_axi_ram.mem[i];
            if (data != 0)
                $display("mem[0x%0h] = %h", i, data);
        end
        $display("=============================================================================\n");
    endfunction

endinterface
