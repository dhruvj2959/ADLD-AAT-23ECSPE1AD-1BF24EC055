// MODULE 05: PROGRAMMABLE TIMER MODULE - RTL & TESTBENCH
`timescale 1ns / 1ps

module timer_module (
    input        clk,
    input        rst,
    input        load,
    input        en,
    input  [3:0] load_val,
    output reg [3:0] count,
    output       timeout
);
    assign timeout = (count == 4'b0000);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0000;
        else if (load)
            count <= load_val;
        else if (en && count != 4'b0000)
            count <= count - 1'b1;
    end
endmodule

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
        #10 rst = 0; load = 1; // Load preset value 5
        #10 load = 0; en = 1;  // Enable countdown
        #70 $finish;
    end
endmodule
