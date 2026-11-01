`timescale 1ns / 1ps
module tb_ring_counter_4bit;
    reg        clk, rst;
    wire [3:0] q;

    ring_counter_4bit uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("ring_counter.vcd");
        $dumpvars(0, tb_ring_counter_4bit);
        $monitor("Time=%0t | rst=%b | Ring Output q=%b", $time, rst, q);

        clk = 0; rst = 1;
        #10 rst = 0;
        #60 $finish;
    end
endmodule
