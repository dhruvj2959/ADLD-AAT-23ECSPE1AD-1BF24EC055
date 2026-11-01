// 1. Moore FSM - Overlapping "101" Sequence Detector
module fsm_moore_101 (
    input      clk,
    input      rst,
    input      din,
    output reg dout
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= S0;
        else     state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: next_state = din ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        dout = (state == S3) ? 1'b1 : 1'b0;
    end
endmodule

// 2. Mealy FSM - Overlapping "101" Sequence Detector
module fsm_mealy_101 (
    input      clk,
    input      rst,
    input      din,
    output reg dout
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= S0;
        else     state <= next_state;
    end

    always @(*) begin
        dout = 1'b0;
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: begin
                next_state = din ? S1 : S0;
                dout       = din ? 1'b1 : 1'b0;
            end
            default: next_state = S0;
        endcase
    end
endmodule
