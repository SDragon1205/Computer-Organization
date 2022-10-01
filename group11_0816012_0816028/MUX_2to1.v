/***************************************************
Student Name:¡È•Ù∞a°B©P©s¡æ
Student ID: group11_0816012_0816028 
***************************************************/


   `timescale 1ns/1ps

   module MUX_2to1(
       input  [31:0] data0_i,
       input  [31:0] data1_i,
       input         select_i,
       output [31:0] data_o
   );

   assign data_o = (select_i==0)?data0_i:data1_i;

   endmodule
