`timescale 1ns / 1ps
module tb_timer_module;
    reg        clk, rst, load, en;
    reg  [3:0] load_val;
    wire [3:0] count;
    wire       timeout;

    timer_module uut (
        .clk(clk), .rst(rst), .load(load), .en(en),
        .load_val(load_val), .count(count), .timeout(timeout)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("timer_module.vcd");
        $dumpvars(0, tb_timer_module);
        $monitor("Time=%0t | rst=%b load=%b en=%b | count=%d timeout=%b",
                 $time, rst, load, en, count, timeout);

        clk = 0; rst = 1; load = 0; en = 0; load_val = 4'd5;
        #10 rst = 0; load = 1;
        #10 load = 0; en = 1;
        #70 $finish;
    end
endmodule
