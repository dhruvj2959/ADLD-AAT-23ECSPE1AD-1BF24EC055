module timer_module (
    input        clk,
    input        rst,
    input        load,
    input        en,
    input  [3:0] load_val,
    output reg [3:0] count,
    output       timeout
);
    assign timeout = (count == 4'b0000);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0000;
        else if (load)
            count <= load_val;
        else if (en && count != 4'b0000)
            count <= count - 1'b1;
    end
endmodule
