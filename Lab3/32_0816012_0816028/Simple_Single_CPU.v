/***************************************************
Student Name:  ¡È•Ù∞a ©P©s¡æ
Student ID:  0816012 0816028
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] one_ist = 4;
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire [31:0] ALUin1, ALUin2;
wire [1:0] ALUOp;
wire [3:0]ALU_control;
wire zero,cout,overflow;
wire [31:0]imm_4 = 4;
wire Branch;
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
        
assign ALUin1 = RSdata_o;
assign ALUin2 = (ALUSrc) ? ((instr[31]) ? {20'hfffff, instr[31 -: 12] } : { 20'h00000,instr[31 -: 12]}) : RTdata_o;
		
Decoder Decoder(
        instr,
        ALUSrc,
        RegWrite,
        Branch,
        ALUOp
	    );	

Adder PC_plus_4_Adder(
        pc_o,
        one_ist,
        pc_i
	    );
		
	
			
ALU_Ctrl ALU_Ctrl(
        {instr[30], instr[14:12]},
        ALUOp,
        ALU_control
		);
		
alu alu(
        rst_i,
        ALUin1,
        ALUin2,
        ALU_control,
        ALUresult,
        zero, cout, overflow
		);
	
		
endmodule
		  


