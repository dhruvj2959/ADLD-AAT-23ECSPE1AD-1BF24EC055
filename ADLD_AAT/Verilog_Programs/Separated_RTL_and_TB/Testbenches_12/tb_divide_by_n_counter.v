`timescale 1ns / 1ps
module tb_divide_by_n_counter;
    reg        clk, rst;
    wire [2:0] count;
    wire       div_clk;

    divide_by_n_counter #(.N(5), .WIDTH(3)) uut (
        .clk(clk), .rst(rst),
        .count(count), .div_clk(div_clk)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("divide_by_n.vcd");
        $dumpvars(0, tb_divide_by_n_counter);
        $monitor("Time=%0t | rst=%b | count=%d | div_clk=%b",
                 $time, rst, count, div_clk);

        clk = 0; rst = 1;
        #10 rst = 0;
        #120 $finish;
    end
endmodule
