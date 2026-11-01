// MODULE 12: RANDOM SEQUENCE GENERATOR (4-BIT LFSR) - RTL & TESTBENCH
`timescale 1ns / 1ps

module lfsr_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    wire feedback;
    // Primitive polynomial: x^4 + x^3 + 1
    assign feedback = q[3] ^ q[2];

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b1111; // Must initialize to non-zero seed
        else
            q <= {q[2:0], feedback};
    end
endmodule

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
