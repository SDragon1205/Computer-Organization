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

reg [3:0] alu_ctrl_o;

  always@ (*) begin
    case(ALUOp)
	  2'b00: begin // I, S type
	      alu_ctrl_o = 4'b0010;
	  end
	  2'b10: begin // R type
	    casex(instr)
		  4'b0000: alu_ctrl_o = 4'b0010; //add
		  4'b1000: alu_ctrl_o = 4'b0110; //sub
		  4'b0111: alu_ctrl_o = 4'b0000; //and
		  4'b0110: alu_ctrl_o = 4'b0001; //or
		  4'b0100: alu_ctrl_o = 4'b0011; //xor
		  4'bx010: alu_ctrl_o = 4'b0111; //slt , slti
		  default: alu_ctrl_o = 4'b0010;
		endcase
	  end
	  2'b11: begin //I type
	      case(instr[2:0])
		      3'b000: alu_ctrl_o = 4'b0010; //addi
		      3'b001: alu_ctrl_o = 4'b1011; //slli
		      3'b010: alu_ctrl_o = 4'b0111; //slti
		      default:alu_ctrl_o = 4'b1111;
	      endcase
	  end
	  default: alu_ctrl_o = 4'b0010;
	endcase
end

assign ALU_Ctrl_o = alu_ctrl_o;

endmodule

//R: add, sub, or, and, xor, slt // 10
//I: addi, slli, slti, lw, nop // 00
//S: sw // 00
