`timescale 1ns / 1ps
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
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #20;
        $finish;
    end
endmodule
