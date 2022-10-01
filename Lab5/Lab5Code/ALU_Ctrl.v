/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output wire	[4-1:0] ALU_Ctrl_o
	);

  always@ (*) begin
    case(ALUOp):
	  2'b00: begin // I, S type
	    case([2:0]instr):
		  //3'b000: ALU_Ctrl_o = 4'b0010; //addi
		  3'b0x0: ALU_Ctrl_o = 4'b1111; //addi, lw, sw
		  3'b001: ALU_Ctrl_o = 4'b1011; //slli
		  //3'b010: ALU_Ctrl_o = 4'b1111; //lw, sw
		endcase
	  end
	  2'b10: begin // R type
	    case(instr):
		  4'b0000: ALU_Ctrl_o = 4'b0010; //add
		  4'b1000: ALU_Ctrl_o = 4'b0110; //sub
		  4'b0111: ALU_Ctrl_o = 4'b0000; //and
		  4'b0110: ALU_Ctrl_o = 4'b0001; //or
		  4'b0100: ALU_Ctrl_o = 4'b0011; //xor
		  4'bx010: ALU_Ctrl_o = 4'b0111; //slt , slti
		endcase
	  end
	endcase
  end
  end

endmodule

//R: add, sub, or, and, xor, slt // 10
//I: addi, slli, slti, lw, nop // 00
//S: sw // 00
