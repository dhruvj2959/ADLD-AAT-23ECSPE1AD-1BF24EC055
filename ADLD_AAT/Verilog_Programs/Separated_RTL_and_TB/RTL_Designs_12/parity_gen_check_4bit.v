module parity_gen_check_4bit (
    input  [3:0] data_in,
    input        parity_in,
    output       even_parity_out,
    output       odd_parity_out,
    output       parity_error
);
    assign even_parity_out = ^data_in;
    assign odd_parity_out  = ~(^data_in);
    assign parity_error    = ^{data_in, parity_in};
endmodule
