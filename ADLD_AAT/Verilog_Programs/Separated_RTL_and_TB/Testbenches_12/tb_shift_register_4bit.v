`timescale 1ns / 1ps
module tb_shift_register_4bit;
    reg        clk, rst, serial_in;
    wire       serial_out;
    wire [3:0] parallel_out;

    shift_register_4bit uut (
        .clk(clk), .rst(rst), .serial_in(serial_in),
        .serial_out(serial_out), .parallel_out(parallel_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("shift_register.vcd");
        $dumpvars(0, tb_shift_register_4bit);
        $monitor("Time=%0t | rst=%b sin=%b | parallel_out=%b | sout=%b",
                 $time, rst, serial_in, parallel_out, serial_out);

        clk = 0; rst = 1; serial_in = 0;
        #10 rst = 0;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #40;
        $finish;
    end
endmodule
