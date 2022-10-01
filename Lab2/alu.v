/***************************************************
Student Name:周孟謙
Student ID:0816028
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg  [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);


wire [32-1:0]results;
wire carryout0,  carryout1, carryout2, carryout3, carryout4, carryout5, carryout6, carryout7, carryout8, carryout9, carryout10, carryout11, carryout12, carryout13, carryout14, carryout15, carryout16, carryout17, carryout18, carryout19, carryout20, carryout21, carryout22, carryout23, carryout24, carryout25, carryout26, carryout27, carryout28, carryout29, carryout30, carryout31;
ALU_1bit UUT0(src1[0], src2[0], ALU_control[3], ALU_control[2], ALU_control[2], ALU_control[1:0], results[0], carry0);
ALU_1bit UUT1(src1[1], src2[1], ALU_control[3], ALU_control[2], carry0, ALU_control[1:0], results[1], carry1);
ALU_1bit UUT2(src1[2], src2[2], ALU_control[3], ALU_control[2], carry1, ALU_control[1:0], results[2], carry2);
ALU_1bit UUT3(src1[3], src2[3], ALU_control[3], ALU_control[2], carry2, ALU_control[1:0], results[3], carry3);
ALU_1bit UUT4(src1[4], src2[4], ALU_control[3], ALU_control[2], carry3, ALU_control[1:0], results[4], carry4);
ALU_1bit UUT5(src1[5], src2[5], ALU_control[3], ALU_control[2], carry4, ALU_control[1:0], results[5], carry5);
ALU_1bit UUT6(src1[6], src2[6], ALU_control[3], ALU_control[2], carry5, ALU_control[1:0], results[6], carry6);
ALU_1bit UUT7(src1[7], src2[7], ALU_control[3], ALU_control[2], carry6, ALU_control[1:0], results[7], carry7);
ALU_1bit UUT8(src1[8], src2[8], ALU_control[3], ALU_control[2], carry7, ALU_control[1:0], results[8], carry8);
ALU_1bit UUT9(src1[9], src2[9], ALU_control[3], ALU_control[2], carry8, ALU_control[1:0], results[9], carry9);
ALU_1bit UUT10(src1[10], src2[10], ALU_control[3], ALU_control[2], carry9, ALU_control[1:0], results[10], carry10);
ALU_1bit UUT11(src1[11], src2[11], ALU_control[3], ALU_control[2], carry10, ALU_control[1:0], results[11], carry11);
ALU_1bit UUT12(src1[12], src2[12], ALU_control[3], ALU_control[2], carry11, ALU_control[1:0], results[12], carry12);
ALU_1bit UUT13(src1[13], src2[13], ALU_control[3], ALU_control[2], carry12, ALU_control[1:0], results[13], carry13);
ALU_1bit UUT14(src1[14], src2[14], ALU_control[3], ALU_control[2], carry13, ALU_control[1:0], results[14], carry14);
ALU_1bit UUT15(src1[15], src2[15], ALU_control[3], ALU_control[2], carry14, ALU_control[1:0], results[15], carry15);
ALU_1bit UUT16(src1[16], src2[16], ALU_control[3], ALU_control[2], carry15, ALU_control[1:0], results[16], carry16);
ALU_1bit UUT17(src1[17], src2[17], ALU_control[3], ALU_control[2], carry16, ALU_control[1:0], results[17], carry17);
ALU_1bit UUT18(src1[18], src2[18], ALU_control[3], ALU_control[2], carry17, ALU_control[1:0], results[18], carry18);
ALU_1bit UUT19(src1[19], src2[19], ALU_control[3], ALU_control[2], carry18, ALU_control[1:0], results[19], carry19);
ALU_1bit UUT20(src1[20], src2[20], ALU_control[3], ALU_control[2], carry19, ALU_control[1:0], results[20], carry20);
ALU_1bit UUT21(src1[21], src2[21], ALU_control[3], ALU_control[2], carry20, ALU_control[1:0], results[21], carry21);
ALU_1bit UUT22(src1[22], src2[22], ALU_control[3], ALU_control[2], carry21, ALU_control[1:0], results[22], carry22);
ALU_1bit UUT23(src1[23], src2[23], ALU_control[3], ALU_control[2], carry22, ALU_control[1:0], results[23], carry23);
ALU_1bit UUT24(src1[24], src2[24], ALU_control[3], ALU_control[2], carry23, ALU_control[1:0], results[24], carry24);
ALU_1bit UUT25(src1[25], src2[25], ALU_control[3], ALU_control[2], carry24, ALU_control[1:0], results[25], carry25);
ALU_1bit UUT26(src1[26], src2[26], ALU_control[3], ALU_control[2], carry25, ALU_control[1:0], results[26], carry26);
ALU_1bit UUT27(src1[27], src2[27], ALU_control[3], ALU_control[2], carry26, ALU_control[1:0], results[27], carry27);
ALU_1bit UUT28(src1[28], src2[28], ALU_control[3], ALU_control[2], carry27, ALU_control[1:0], results[28], carry28);
ALU_1bit UUT29(src1[29], src2[29], ALU_control[3], ALU_control[2], carry28, ALU_control[1:0], results[29], carry29);
ALU_1bit UUT30(src1[30], src2[30], ALU_control[3], ALU_control[2], carry29, ALU_control[1:0], results[30], carry30);
ALU_1bit UUT31(src1[31], src2[31], ALU_control[3], ALU_control[2], carry30, ALU_control[1:0], results[31], carry31);

always@(*) begin
  if(rst_n) begin
	result = ALU_control[1:0] == 2'b11 ? results[30] : results;
	zero = result ==0;
	cout = ALU_control[1:0] == 2'b10 ? carry31 : 0;
	overflow = ALU_control[1:0] == 2'b10 ? carry31 ^ carry30 : 0;
  end
  else begin
    result = 32'b0;
	zero = 0;
	cout = 0;
	overflow = 0;
  end
end

endmodule
