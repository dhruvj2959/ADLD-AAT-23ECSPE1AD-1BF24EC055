// MODULE 08: 4-BIT SYNCHRONOUS AND ASYNCHRONOUS COUNTERS - RTL & TESTBENCH
`timescale 1ns / 1ps

// 1. 4-Bit Synchronous Binary Up Counter
module sync_counter_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else
            q <= q + 1'b1;
    end
endmodule

// 2. 4-Bit Asynchronous (Ripple) Binary Up Counter
module async_counter_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst)
        if (rst) q[0] <= 1'b0; else q[0] <= ~q[0];

    always @(negedge q[0] or posedge rst)
        if (rst) q[1] <= 1'b0; else q[1] <= ~q[1];

    always @(negedge q[1] or posedge rst)
        if (rst) q[2] <= 1'b0; else q[2] <= ~q[2];

    always @(negedge q[2] or posedge rst)
        if (rst) q[3] <= 1'b0; else q[3] <= ~q[3];
endmodule

module tb_counters_4bit;
    reg        clk, rst;
    wire [3:0] q_sync, q_async;

    sync_counter_4bit  uut_sync  (.clk(clk), .rst(rst), .q(q_sync));
    async_counter_4bit uut_async (.clk(clk), .rst(rst), .q(q_async));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("counters_4bit.vcd");
        $dumpvars(0, tb_counters_4bit);
        $monitor("Time=%0t | rst=%b | Sync_Count=%d (%b) | Async_Count=%d (%b)",
                 $time, rst, q_sync, q_sync, q_async, q_async);

        clk = 0; rst = 1;
        #10 rst = 0;
        #170 $finish;
    end
endmodule
