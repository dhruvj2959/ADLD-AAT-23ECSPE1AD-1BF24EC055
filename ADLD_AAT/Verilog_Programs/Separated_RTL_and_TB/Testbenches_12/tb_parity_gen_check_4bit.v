`timescale 1ns / 1ps
module tb_parity_gen_check_4bit;
    reg  [3:0] data_in;
    reg        parity_in;
    wire       even_parity_out, odd_parity_out, parity_error;

    parity_gen_check_4bit uut (
        .data_in(data_in),
        .parity_in(parity_in),
        .even_parity_out(even_parity_out),
        .odd_parity_out(odd_parity_out),
        .parity_error(parity_error)
    );

    initial begin
        $dumpfile("parity_gen_check.vcd");
        $dumpvars(0, tb_parity_gen_check_4bit);
        $monitor("Time=%0t | Data=%b ParIn=%b | EvenGen=%b OddGen=%b | Error=%b",
                 $time, data_in, parity_in, even_parity_out, odd_parity_out, parity_error);

        data_in = 4'b1011; parity_in = 1'b1; #10;
        data_in = 4'b1011; parity_in = 1'b0; #10;
        data_in = 4'b1100; parity_in = 1'b0; #10;
        data_in = 4'b0111; parity_in = 1'b0; #10;
        $finish;
    end
endmodule
