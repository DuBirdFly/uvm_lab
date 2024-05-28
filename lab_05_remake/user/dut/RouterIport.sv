module RouterIPort (
    input                   clk,
    input                   reset_n,

    input                   i_frame,
    input                   i_data,

    output logic [1:0]      o_dst_addr,
    output logic            o_req,
    input                   i_gnt

);

localparam CNT_MAX = 2;

typedef enum logic [1:0] { 
    S_IDLE  = 'b00,
    S_ADDR  = 'b01,
    S_GRANT = 'b10,
    S_DATA  = 'b11
} state_t;

state_t cur_state, nxt_state;

logic [3:0] cnt;
logic       r_req;

assign o_req = r_req & i_frame;

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        cur_state <= S_IDLE;
    end else begin
        cur_state <= nxt_state;
    end
end

always_comb begin
    case (cur_state)
        S_IDLE: begin
            if (i_frame)
                nxt_state = S_ADDR;
            else
                nxt_state = S_IDLE;
        end
        S_ADDR: begin
            if (cnt == CNT_MAX & ~i_gnt)
                nxt_state = S_GRANT;
            else if (cnt == CNT_MAX & i_gnt)
                nxt_state = S_DATA; 
            else
                nxt_state = S_ADDR;
        end
        S_GRANT: begin
            if (i_gnt)
                nxt_state = S_DATA;
            else
                nxt_state = S_GRANT;
        end
        S_DATA: begin
            if (~i_frame)
                nxt_state = S_IDLE;
            else
                nxt_state = S_DATA;
        end
        default: begin
            nxt_state = S_IDLE;
        end
    endcase
end

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        cnt <= 0;
    else if (nxt_state == S_ADDR)
        cnt <= cnt + 1;
    else if (nxt_state == S_IDLE)
        cnt <= 0;
end

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        o_dst_addr <= 0;
    else if (nxt_state == S_ADDR)
        o_dst_addr <= {i_data, o_dst_addr[1]};
end

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        r_req <= 0;
    else begin
        if (nxt_state == S_ADDR && cnt == CNT_MAX - 1)
            r_req <= 1;
        else if (nxt_state == S_IDLE)
            r_req <= 0;
    end
end

endmodule