`timescale 1ns / 100ps

`define DUMP_VCD

module tb_Router;

    bit clk = 0;
    always #5 clk = ~clk;

    bit rst_n = 1'b0;
    initial #50 rst_n = 1'b1;

    logic [3:0] i_frame = 0;
    logic [3:0] i_valid = 0;
    logic [3:0] i_data  = 0;
    logic [3:0] o_grant;

    logic [3:0] o_frame;
    logic [3:0] o_valid;
    logic [3:0] o_data;

    task delay(int N);
        for (int i = 0; i < N; i = i + 1) begin
            @(posedge clk);
            #1;
        end
    endtask

    function void print_finish();
        $display("\n===============================");
        $display("===== Simulation finished =====");
        $display("===============================\n");
    endfunction

    initial begin
        // IDLE
        delay(20);
        // ADDR
        i_frame[0] = 1;
        i_valid[0] = 0;
        i_data[0]  = 1;
        delay(1);
        i_data[0]  = 1;
        delay(1);
        // DATA
        i_valid[0] = 1;
        i_data[0]  = 0; delay(1);
        i_data[0]  = 0; delay(1);
        i_data[0]  = 0; delay(1);
        i_data[0]  = 0; delay(1);
        i_data[0]  = 1; delay(1);
        i_data[0]  = 1; delay(1);
        i_data[0]  = 1; delay(1);
        i_data[0]  = 1; delay(1);
        i_valid[0] = 0;
        i_frame[0] = 0;
    end

    initial begin



    end


    Router u_Router (
        .clk        ( clk           ),
        .reset_n    ( rst_n         ),
        .i_frame    ( i_frame       ),
        .i_valid    ( i_valid       ),
        .i_data     ( i_data        ),
        .o_grant    ( o_grant       ),
        .o_frame    ( o_frame       ),
        .o_valid    ( o_valid       ),
        .o_data     ( o_data        )
    );

    initial begin
        #5000;
        print_finish();
        $finish;
    end

    `ifdef DUMP_VCD
        initial begin
            $dumpfile("vsim.vcd");
            $dumpvars(0, tb_Router);
        end
    `endif


endmodule