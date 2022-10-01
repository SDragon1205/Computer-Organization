/***************************************************
Student Name:¡È•Ù∞a°B©P©s¡æ
Student ID: group11_0816012_0816028 
***************************************************/

   `timescale 1ns/1ps

   module alu(
       input                   rst_n,         // negative reset            (input)
       input        [32-1:0]   src1,          // 32 bits source 1          (input)
       input        [32-1:0]   src2,          // 32 bits source 2          (input)
       input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
       output       [32-1:0]   result,        // 32 bits result            (output)
       output               Zero          // 1 bit when the output is 0, zero must be set (output)
   );
   wire signed [31:0] a = src1;
   wire signed [31:0] b = src2;
   reg signed [31:0] r;
   always@ (*) begin
        if(rst_n)
            case(ALU_control[3:2])
                2'b00:begin
                    r = a + b;
                end
                2'b01:begin
                    r = a - b;
                end
                default:begin
                    r = a + b;
                end
            endcase
       else 
            r = 0;
        
   end
   assign result = ALU_control == 4'b0110 ? (a<b) : r;
   assign Zero = ~(|r);

   endmodule
