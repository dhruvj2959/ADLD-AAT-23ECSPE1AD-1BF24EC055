// MODULE 03: 4-BIT PARITY GENERATOR AND CHECKER - RTL & TESTBENCH
`timescale 1ns / 1ps

module parity_gen_check_4bit (
    input  [3:0] data_in,
    input        parity_in,
    output       even_parity_out,
    output       odd_parity_out,
    output       parity_error
);
    // Parity Generation using reduction operators
    assign even_parity_out = ^data_in;     // XOR reduction
    assign odd_parity_out  = ~(^data_in);  // XNOR reduction

    // Even Parity Error Checker (0 = No Error, 1 = Error)
    assign parity_error    = ^{data_in, parity_in};
endmodule

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

        data_in = 4'b1011; parity_in = 1'b1; #10; // Valid Even Parity (Error = 0)
        data_in = 4'b1011; parity_in = 1'b0; #10; // Corrupted Bit (Error = 1)
        data_in = 4'b1100; parity_in = 1'b0; #10; // Valid Even Parity (Error = 0)
        data_in = 4'b0111; parity_in = 1'b0; #10; // Corrupted Bit (Error = 1)
        $finish;
    end
endmodule
