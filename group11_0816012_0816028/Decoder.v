/***************************************************
Student Name:¡È•Ù∞a°B©P©s¡æ
Student ID: group11_0816012_0816028 
***************************************************/

   `timescale 1ns/1ps

   module Decoder(
       input   [7-1:0]     instr_i,
       output              RegWrite,
       output              Branch,
       output              Jump,
       output              WriteBack1,
       output              WriteBack0,
       output              MemRead,
       output              MemWrite,
       output              ALUSrcA,
       output              ALUSrcB,
       output  [2-1:0]     ALUOp
   );
   reg rw, br, j, wb1, wb0, mr, mw, asa, asb;
   reg [1:0] aop;
   always@(*)begin
        case(instr_i)
            7'b0110011:begin //r-type
                rw = 1;
                br = 0;
                j  = 0;
                wb1= 0;
                wb0= 0;
                mr = 0;
                mw = 0;
                asa= 0;
                asb= 0;
                aop= 2'b10;
            end
            7'b0010011:begin //addi
                rw = 1;
                br = 0;
                j  = 0;
                wb1= 0;
                wb0= 0;
                mr = 0;
                mw = 0;
                asa= 0;
                asb= 1;
                aop= 2'b00;
            end
            7'b0000011:begin // lw
                rw = 1;
                br = 0;
                j  = 0;
                wb1= 0;
                wb0= 1;
                mr = 1;
                mw = 0;
                asa= 0;
                asb= 1;
                aop= 2'b00;
            end
            7'b0100011:begin // sw
                rw = 0;
                br = 0;
                j  = 0;
                wb1= 0;
                wb0= 1;
                mr = 0;
                mw = 1;
                asa= 0;
                asb= 1;
                aop= 2'b00;
            end
            7'b1100011:begin // beq
                rw = 0;
                br = 1;
                j  = 0;
                wb1= 0;
                wb0= 1;
                mr = 0;
                mw = 0;
                asa= 0;
                asb= 0;
                aop= 2'b01;
            end
            7'b1101111:begin // jal
                rw = 1;
                br = 0;
                j  = 1;
                wb1= 1;
                wb0= 1;
                mr = 0;
                mw = 0;
                asa= 0;
                asb= 1;
                aop= 2'b11;
            end
            7'b1100111:begin // jalr
                rw = 1;
                br = 0;
                j  = 1;
                wb1= 1;
                wb0= 1;
                mr = 0;
                mw = 0;
                asa= 1;
                asb= 1;
                aop= 2'b11;
            end
            default: begin
                rw = 0;
                br = 0;
                j  = 0;
                wb1= 0;
                wb0= 0;
                mr = 0;
                mw = 0;
                asa= 0;
                asb= 0;
                aop= 2'b00;
            end
        endcase
   end
   assign RegWrite = rw;
   assign Branch = br;
   assign Jump = j;
   assign WriteBack1 = wb1;
   assign WriteBack0 = wb0;
   assign MemRead = mr;
   assign MemWrite = mw;
   assign ALUSrcA = asa;
   assign ALUSrcB = asb;
   assign ALUOp = aop;
   endmodule

