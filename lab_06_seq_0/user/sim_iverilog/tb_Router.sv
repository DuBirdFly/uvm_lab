`timescale 1ns / 1ns

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

    logic [3:0] o_valid;
    logic [3:0] o_data;

    task delay_clk(int N);
        for (int i = 0; i < N; i = i + 1) begin
            @(posedge clk);
            #1;
        end
    endtask

    function void my_exit(int return_code);
        if (return_code == 0) begin
            $display("\n===============================");
            $display("===== Simulation finished =====");
            $display("===============================\n");
        end
        else if (return_code == 1) begin
            $display("\n===============================");
            $display("===== ERROR! OUT of TIME ======");
            $display("===============================\n");
        end
        else begin
            $display("\n===============================");
            $display("==== Unknown return_code! =====");
            $display("===============================\n");
        end
        $finish;
    endfunction

    task automatic send_data(
        input [1:0] iport_id,
        input [1:0] oport_id,
        input [7:0] data
    );

        // ADDR =========================
        i_frame[iport_id] = 1;
        i_valid[iport_id] = 0;
        i_data[iport_id]  = oport_id[0];
        delay_clk(1);
        i_data[iport_id]  = oport_id[1];

        while (o_grant[iport_id] == 0) delay_clk(1);
        // DATA =========================
        i_valid[iport_id] = 1;
        i_data[iport_id]  = data[0]; delay_clk(1);
        i_data[iport_id]  = data[1]; delay_clk(1);
        i_data[iport_id]  = data[2]; delay_clk(1);
        i_data[iport_id]  = data[3]; delay_clk(1);
        i_data[iport_id]  = data[4]; delay_clk(1);
        i_data[iport_id]  = data[5]; delay_clk(1);
        i_data[iport_id]  = data[6]; delay_clk(1);
        i_data[iport_id]  = data[7]; delay_clk(1);
        i_valid[iport_id] = 0;
        i_frame[iport_id] = 0;
        delay_clk(1);

    endtask

    initial begin
        delay_clk(20);

        send_data(0, 3, 8'b01010101);
        send_data(1, 2, 8'b01010101);
        send_data(2, 1, 8'b01010101);
        send_data(3, 0, 8'b01010101);
        delay_clk(50);

        fork
            send_data(0, 3, 8'b01010101);
            send_data(1, 2, 8'b01010101);
            send_data(2, 1, 8'b01010101);
            send_data(3, 0, 8'b01010101);
        join
        delay_clk(50);

        fork
            begin
                send_data(0, 3, 8'b01010101);
            end
            begin
                delay_clk(2);
                send_data(1, 3, 8'b01010101);
            end
        join
        delay_clk(50);

        fork
            send_data(0, 3, 8'b01010101);
            send_data(1, 3, 8'b01010101);
            send_data(2, 3, 8'b01010101);
            send_data(3, 3, 8'b01010101);
        join
        delay_clk(50);



        my_exit(0);
    end

    Router u_Router (
        .clk        ( clk           ),
        .reset_n    ( rst_n         ),
        .i_frame    ( i_frame       ),
        .i_valid    ( i_valid       ),
        .i_data     ( i_data        ),
        .o_grant    ( o_grant       ),
        .o_valid    ( o_valid       ),
        .o_data     ( o_data        )
    );

    initial begin
        $timeformat(-9, 0, " ns", 10);
        #5000;
        my_exit(1);
    end

    `ifdef DUMP_VCD
        initial begin
            $dumpfile("vsim.vcd");
            $dumpvars(0, tb_Router);
        end
    `endif


endmodule