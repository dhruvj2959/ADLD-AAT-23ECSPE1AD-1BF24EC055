`timescale 1ns / 1ps
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
