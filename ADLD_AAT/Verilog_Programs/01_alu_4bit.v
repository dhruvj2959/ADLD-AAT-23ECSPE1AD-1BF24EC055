// MODULE 01: 4-BIT ARITHMETIC LOGIC UNIT (ALU) - RTL & TESTBENCH
`timescale 1ns / 1ps

module alu_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] ALU_Sel,
    output reg [3:0] ALU_Out,
    output reg CarryOut
);
    always @(*) begin
        CarryOut = 1'b0;
        case (ALU_Sel)
            3'b000: {CarryOut, ALU_Out} = A + B;       // Addition
            3'b001: {CarryOut, ALU_Out} = A - B;       // Subtraction
            3'b010: ALU_Out = A & B;                   // Bitwise AND
            3'b011: ALU_Out = A | B;                   // Bitwise OR
            3'b100: ALU_Out = A ^ B;                   // Bitwise XOR
            3'b101: ALU_Out = ~A;                      // Bitwise NOT (Invert A)
            3'b110: ALU_Out = A << 1;                  // Logical Shift Left
            3'b111: ALU_Out = A >> 1;                  // Logical Shift Right
            default: ALU_Out = 4'b0000;
        endcase
    end
endmodule

module tb_alu_4bit;
    reg  [3:0] A, B;
    reg  [2:0] ALU_Sel;
    wire [3:0] ALU_Out;
    wire CarryOut;
    integer i;

    alu_4bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
    );

    initial begin
        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, tb_alu_4bit);
        $monitor("Time=%0t | A=%b B=%b | Sel=%b | Out=%b CarryOut=%b",
                 $time, A, B, ALU_Sel, ALU_Out, CarryOut);

        A = 4'b1010; B = 4'b0101;
        for (i = 0; i < 8; i = i + 1) begin
            ALU_Sel = i[2:0];
            #10;
        end
        // Test addition overflow
        A = 4'b1111; B = 4'b0010; ALU_Sel = 3'b000; #10;
        $finish;
    end
endmodule
