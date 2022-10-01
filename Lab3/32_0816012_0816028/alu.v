/***************************************************
Student Name:  ¡È•Ù∞a ©P©s¡æ
Student ID:  0816012 0816028
***************************************************/

`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	signed    [32-1:0]	src1,          // 32 bits source 1          (input)
	input	signed     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
parameter Add = 4'b0010;
parameter Sub = 4'b0110;
parameter And = 4'b0000;
parameter Or  = 4'b0001;
parameter Xor = 4'b0011;
parameter Slt = 4'b0111;
parameter Sll = 4'b1011;
parameter Sra = 4'b1111;

always @(*)begin
    if(rst_n)begin
        case(ALU_control)
            Add: begin
                result = src1 + src2;
            end
            Sub:begin
                result = src1 - src2;
            end
            And:begin
                result = src1 & src2;
            end
            Or:begin
                result = src1 | src2;
            end
            Xor: begin
                result = src1 ^  src2;
            end
            Slt: begin
                result = src1 < src2;
            end
            Sll: begin
                result = src1 << src2;
            end
            Sra: begin
                result = src1 >>> src2;
            end
            default: begin
                result = src1 - src2;
            end
        endcase
        zero = !(|result);
        cout = 0;
        overflow = 0;
    end
    else begin
        result = 32'h0000_0000;
        zero = 0;
        cout = 0;
        overflow = 0;
    end
end

endmodule
