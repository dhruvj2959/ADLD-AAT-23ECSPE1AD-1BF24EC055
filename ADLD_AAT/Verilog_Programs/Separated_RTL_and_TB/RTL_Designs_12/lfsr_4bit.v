module lfsr_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    wire feedback;
    assign feedback = q[3] ^ q[2];

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b1111;
        else
            q <= {q[2:0], feedback};
    end
endmodule
