`timescale 1ns / 1ps
/***************************************************
Student Name: 
Student ID: 
***************************************************/

module Hazard_detection(
input [4:0] IFID_regRs,
input [4:0] IFID_regRt,
input [4:0] IDEXE_regRd,
input IDEXE_memRead,
output PC_write,
output IFID_write,
output control_output_select
);

    
assign control_output_select = IDEXE_memRead && (IFID_regRs == IDEXE_regRd || IFID_regRt == IDEXE_regRd);
assign PC_write = ~control_output_select;
assign IFID_write = ~control_output_select; 

    
endmodule
