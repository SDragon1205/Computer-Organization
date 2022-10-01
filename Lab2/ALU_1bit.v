/***************************************************
Student Name: 周孟謙
Student ID: 0816028
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input  	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */

reg temp1;
reg temp2;
reg temp3;
reg temp4;
reg temp5;

always@(src1 or src2 or Ainvert or Binvert or Cin or operation)
  begin
  case (Ainvert)
    1'b0:  temp1 = src1;   // 0
    1'b1:  temp1 = ~src1;   // 1
  endcase
  //$display("temp1 %d", temp1);
  case (Binvert)
    1'b0:  temp2 = src2;   // 0
    1'b1:  temp2 = ~src2;   // 1
  endcase
  //$display("temp2 %d", temp2);
  temp3 = temp1 & temp2;
  temp4 = temp1 | temp2;
  {cout, temp5} = temp1 + temp2 + Cin;
  //$display("temp3 %d", temp3);
  //$display("temp4 %d", temp4);
  //$display("temp5 %d", temp5);
  case (operation)
    2'b00:  result = temp3;   // AND
    2'b01:  result = temp4;   // OR
    2'b10:  result = temp5;    // addition
    2'b11:  result = temp5;    // addition
  endcase
end

endmodule
