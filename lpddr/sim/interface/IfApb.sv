interface IfApb(
    input bit           pclk
);

    // APB interface
    logic                    presetn;
    logic [`APB_DEPTH - 1:0] paddr;
    logic [`APB_WIDTH - 1:0] pwdata;
    logic                    pwrite;
    logic                    psel;
    logic                    penable;
    logic                    pready;
    logic [`APB_WIDTH - 1:0] prdata;

    clocking drv_cb @(posedge pclk);
        default input #1 output #1;
        output presetn;
        output paddr;
        output pwdata;
        output pwrite;
        output psel;
        output penable;
        input  pready;
        input  prdata;
    endclocking

    clocking mon_cb @(posedge pclk);
        default input #1 output #1;
        input presetn;
        input paddr;
        input pwdata;
        input pwrite;
        input psel;
        input penable;
        input pready;
        input prdata;
    endclocking

endinterface