`timescale 1ns / 1ps
module tb_lfsr_4bit;
    reg        clk, rst;
    wire [3:0] q;

    lfsr_4bit uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("lfsr_4bit.vcd");
        $dumpvars(0, tb_lfsr_4bit);
        $monitor("Time=%0t | rst=%b | Pseudo-Random Output q=%b (%d)",
                 $time, rst, q, q);

        clk = 0; rst = 1;
        #10 rst = 0;
        #160 $finish;
    end
endmodule
