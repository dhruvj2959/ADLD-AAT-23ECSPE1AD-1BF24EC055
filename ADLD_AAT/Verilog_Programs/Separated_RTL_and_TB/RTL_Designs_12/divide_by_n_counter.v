module divide_by_n_counter #(
    parameter N = 5,
    parameter WIDTH = 3
)(
    input                   clk,
    input                   rst,
    output reg [WIDTH-1:0]  count,
    output reg              div_clk
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count   <= 0;
            div_clk <= 1'b0;
        end else if (count == N - 1) begin
            count   <= 0;
            div_clk <= 1'b1;
        end else begin
            count   <= count + 1'b1;
            div_clk <= 1'b0;
        end
    end
endmodule
