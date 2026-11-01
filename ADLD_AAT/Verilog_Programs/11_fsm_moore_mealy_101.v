// MODULE 11: MEALY AND MOORE FSMS (101 SEQUENCE DETECTOR) - RTL & TESTBENCH
`timescale 1ns / 1ps

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

module tb_fsm_101;
    reg  clk, rst, din;
    wire dout_moore, dout_mealy;

    fsm_moore_101 uut_moore (.clk(clk), .rst(rst), .din(din), .dout(dout_moore));
    fsm_mealy_101 uut_mealy (.clk(clk), .rst(rst), .din(din), .dout(dout_mealy));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fsm_101.vcd");
        $dumpvars(0, tb_fsm_101);
        $monitor("Time=%0t | rst=%b din=%b | Moore_Out=%b | Mealy_Out=%b",
                 $time, rst, din, dout_moore, dout_mealy);

        clk = 0; rst = 1; din = 0;
        #10 rst = 0;
        // Overlapping sequence: 1 -> 0 -> 1 -> 0 -> 1
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #20;
        $finish;
    end
endmodule
