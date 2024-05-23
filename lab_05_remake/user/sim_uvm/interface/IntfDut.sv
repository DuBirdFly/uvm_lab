interface IntfDut(
    input bit       clk
);

    logic           reset_n;

    logic [15:0]    i_frame;
    logic [15:0]    i_valid;
    logic [15:0]    i_data;

    logic [15:0]    o_frame;
    logic [15:0]    o_valid;
    logic [15:0]    o_busy;
    logic [15:0]    o_data;

    clocking drv_cb @(posedge clk);
        default input #1 output #1;
        output reset_n;
        output i_frame;
        output i_valid;
        output i_data;
        input  o_busy;
    endclocking

    clocking mon_in_cb @(posedge clk);
        default input #1 output #1;
        input  i_frame;
        input  i_valid;
        input  i_data;
        input  o_busy;
    endclocking

    clocking mon_out_cb @(posedge clk);
        default input #1 output #1;
        input  o_frame;
        input  o_valid;
        input  o_data;
    endclocking

    modport driver(clocking drv_cb, output reset_n);
    modport monitor_in(clocking mon_in_cb);
    modport monitor_out(clocking mon_out_cb);

endinterface
