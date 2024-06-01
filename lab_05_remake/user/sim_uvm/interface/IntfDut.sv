interface IntfDut(
    input bit       clk
);

    logic           reset_n;

    logic [3:0]    i_frame;
    logic [3:0]    i_valid;
    logic [3:0]    i_data;

    logic [3:0]    o_valid;
    logic [3:0]    o_grant;
    logic [3:0]    o_data;

    clocking drv_cb @(posedge clk);
        default input #1 output #1;
        output reset_n;
        output i_frame;
        output i_valid;
        output i_data;
        input  o_grant;
    endclocking

    clocking mon_in_cb @(posedge clk);
        default input #1 output #1;
        input  i_frame;
        input  i_valid;
        input  i_data;
        input  o_grant;
    endclocking

    clocking mon_out_cb @(posedge clk);
        default input #1 output #1;
        input  o_valid;
        input  o_data;
    endclocking

    modport driver(clocking drv_cb, output reset_n);
    modport monitor_in(clocking mon_in_cb);
    modport monitor_out(clocking mon_out_cb);

endinterface
