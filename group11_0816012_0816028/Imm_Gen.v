/***************************************************
Student Name:¡È•Ù∞a°B©P©s¡æ
Student ID: group11_0816012_0816028 
***************************************************/


   `timescale 1ns/1ps

   module Imm_Gen(
       input  [31:0] instr_i,
       output reg[31:0] Imm_Gen_o
   );

   //Internal Signals
   wire    [7-1:0] opcode;
   wire    [2:0]   func3;
   wire    [3-1:0] Instr_field;
   parameter addi = 7'b0010011;
   parameter lw   = 7'b0000011;
   parameter sw   = 7'b0100011;
   parameter beq  = 7'b1100011;
   parameter jal  = 7'b1101111;
   parameter jalr = 7'b1100111;

   assign opcode = instr_i[6:0];
   assign func3  = instr_i[14:12];

   always @(*) begin
        case(opcode)
            addi: begin
                Imm_Gen_o[11:0]  = instr_i[31:20];
                Imm_Gen_o[31:12] = {20{instr_i[31]}};
            end
            lw:begin
                Imm_Gen_o[11:0]  = instr_i[31:20];
                Imm_Gen_o[31:12] = {20{instr_i[31]}};
            end
            sw: begin
                Imm_Gen_o[11:5]  = instr_i[31:25];
                Imm_Gen_o[4:0]   = instr_i[11:7];
                Imm_Gen_o[31:12] = {20{instr_i[31]}};
            end
            beq: begin
                Imm_Gen_o[0]     = 0;
                Imm_Gen_o[4:1]   = instr_i[11:8];
                Imm_Gen_o[10:5]  = instr_i[30:25];
                Imm_Gen_o[11]    = instr_i[7];
                Imm_Gen_o[31:12] = {20{instr_i[31]}};
            end
            jal: begin
                Imm_Gen_o[0] = 0;
                {Imm_Gen_o[20], Imm_Gen_o[10: 1], Imm_Gen_o[11], Imm_Gen_o[19:12] }= instr_i[31:12];
                Imm_Gen_o[31:21] = {11{instr_i[31]}};
            end
            jalr: begin
                Imm_Gen_o[11:0]  = instr_i[31:20];
                Imm_Gen_o[31:12] = {20{instr_i[31]}};
            end
            default: begin
                Imm_Gen_o = 0;
            end
        endcase
   end

   endmodule
