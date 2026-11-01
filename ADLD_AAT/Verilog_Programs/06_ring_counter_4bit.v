// MODULE 06: 4-BIT RING COUNTER - RTL & TESTBENCH
`timescale 1ns / 1ps

module ring_counter_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b1000;       // Initialize one-hot seed on reset
        else
            q <= {q[0], q[3:1]}; // Circular right shift
    end
endmodule

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
