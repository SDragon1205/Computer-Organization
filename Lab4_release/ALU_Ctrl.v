/***************************************************
Student Name:
Student ID: Lab4_release
***************************************************/

   `timescale 1ns/1ps
   /*instr[30,14:12]*/
   module ALU_Ctrl(
       input       [4-1:0] instr,
       input       [2-1:0] ALUOp,
       output      [4-1:0] ALU_Ctrl_o
   );
   wire [2:0] func3;
   assign func3 = instr[2:0];
   /* Write your code HERE */
  always@ (*) begin
    case(ALUOp):
	  2'b00: ALU_Ctrl_o = 4'b0000;
	  2'b01: ALU_Ctrl_o = 4'b0101;
	  2'b10: begin
	    case(instr):
		  4'b0000: ALU_Ctrl_o = 4'b0010;
		  4'b0010: ALU_Ctrl_o = 4'b0111;
	    endcase
	  end
	  2'b11: ALU_Ctrl_o = 4'b1111;
    endcase
  end

   endmodule

