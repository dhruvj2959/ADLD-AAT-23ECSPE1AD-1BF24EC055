`timescale 1ns / 1ps
module tb_barrel_shifter_4bit;
    reg  [3:0] data_in;
    reg  [1:0] shift_amt;
    wire [3:0] data_out;

    barrel_shifter_4bit uut (
        .data_in(data_in),
        .shift_amt(shift_amt),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("barrel_shifter.vcd");
        $dumpvars(0, tb_barrel_shifter_4bit);
        $monitor("Time=%0t | data_in=%b | shift_amt=%d | data_out=%b",
                 $time, data_in, shift_amt, data_out);

        data_in = 4'b1001;
        shift_amt = 2'b00; #10;
        shift_amt = 2'b01; #10;
        shift_amt = 2'b10; #10;
        shift_amt = 2'b11; #10;
        $finish;
    end
endmodule
