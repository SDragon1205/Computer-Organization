/***************************************************
Student Name:  ¡È•Ù∞a ©P©s¡æ
Student ID:  0816012 0816028
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
  always@ (*) begin
    case(ALUOp)
	  2'b00: ALU_Ctrl_o = 4'b0010;
	  2'b01: ALU_Ctrl_o = 4'b0110;
	  2'b10: begin
	    case(instr)
		  4'b0000: ALU_Ctrl_o = 4'b0010;
		  4'b1000: ALU_Ctrl_o = 4'b0110;
		  4'b0111: ALU_Ctrl_o = 4'b0000;
		  4'b0110: ALU_Ctrl_o = 4'b0001;
		  4'b0100: ALU_Ctrl_o = 4'b0011;
		  4'b0010: ALU_Ctrl_o = 4'b0111;
		  4'b0001: ALU_Ctrl_o = 4'b1011;
		  4'b1101: ALU_Ctrl_o = 4'b1111;
		endcase
	  end
	endcase
  end

endmodule