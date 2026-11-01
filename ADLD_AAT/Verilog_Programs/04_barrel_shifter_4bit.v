// MODULE 04: 4-BIT BARREL SHIFTER - RTL & TESTBENCH
`timescale 1ns / 1ps

module barrel_shifter_4bit (
    input  [3:0] data_in,
    input  [1:0] shift_amt,
    output reg [3:0] data_out
);
    always @(*) begin
        case (shift_amt)
            2'b00: data_out = data_in;
            2'b01: data_out = {data_in[2:0], data_in[3]};
            2'b10: data_out = {data_in[1:0], data_in[3:2]};
            2'b11: data_out = {data_in[0],   data_in[3:1]};
            default: data_out = data_in;
        endcase
    end
endmodule

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
