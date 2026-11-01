`timescale 1ns / 1ps
module tb_comparator_4bit;
    reg  [3:0] A, B;
    wire A_gt_B, A_eq_B, A_lt_B;

    comparator_4bit uut (
        .A(A), .B(B),
        .A_gt_B(A_gt_B), .A_eq_B(A_eq_B), .A_lt_B(A_lt_B)
    );

    initial begin
        $dumpfile("comparator_4bit.vcd");
        $dumpvars(0, tb_comparator_4bit);
        $monitor("Time=%0t | A=%d (%b) B=%d (%b) | GT=%b EQ=%b LT=%b",
                 $time, A, A, B, B, A_gt_B, A_eq_B, A_lt_B);

        A = 4'd8;  B = 4'd3;  #10; // A > B
        A = 4'd5;  B = 4'd5;  #10; // A == B
        A = 4'd2;  B = 4'd12; #10; // A < B
        A = 4'd15; B = 4'd0;  #10; // Boundary test
        $finish;
    end
endmodule
