// 1. 4-Bit Synchronous Binary Up Counter
module sync_counter_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else
            q <= q + 1'b1;
    end
endmodule

// 2. 4-Bit Asynchronous (Ripple) Binary Up Counter
module async_counter_4bit (
    input        clk,
    input        rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst)
        if (rst) q[0] <= 1'b0; else q[0] <= ~q[0];

    always @(negedge q[0] or posedge rst)
        if (rst) q[1] <= 1'b0; else q[1] <= ~q[1];

    always @(negedge q[1] or posedge rst)
        if (rst) q[2] <= 1'b0; else q[2] <= ~q[2];

    always @(negedge q[2] or posedge rst)
        if (rst) q[3] <= 1'b0; else q[3] <= ~q[3];
endmodule
