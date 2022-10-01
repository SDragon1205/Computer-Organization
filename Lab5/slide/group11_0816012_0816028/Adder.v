/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Adder(
    input  [32-1:0] src1_i,
	input  [32-1:0] src2_i,
	output [32-1:0] sum_o
	);
    
wire signed [31:0] a, b, sum;
assign a = src1_i;
assign b = src2_i;
assign sum = a + b;
assign sum_o = sum;

endmodule