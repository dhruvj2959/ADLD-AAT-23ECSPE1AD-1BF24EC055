module comparator_4bit (
    input  [3:0] A,
    input  [3:0] B,
    output reg A_gt_B,
    output reg A_eq_B,
    output reg A_lt_B
);
    always @(*) begin
        A_gt_B = 1'b0;
        A_eq_B = 1'b0;
        A_lt_B = 1'b0;
        if (A > B)
            A_gt_B = 1'b1;
        else if (A < B)
            A_lt_B = 1'b1;
        else
            A_eq_B = 1'b1;
    end
endmodule
