/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] MuxMemtoReg_o;
wire [31:0] ALUresult;
wire [31:0] MuxALUSrc_o;
wire [31:0] decoder_o;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] Imm_Gen_o;
wire [31:0] ALUSrc1_o;
wire [31:0] ALUSrc2_o;
wire [7:0] Mux_control_o;

wire [31:0] pc_add_immediate;
wire [1:0] ALUOp;
wire PC_write;
wire ALUSrc; 
wire RegWrite;
wire Branch;
wire control_output_select;
wire Jump;
wire [31:0] SL1_o;
wire [3:0] ALU_Ctrl_o;
wire zero,cout,ovf;
wire branch_zero;
wire PCSrc;
wire [31:0] DM_o;
wire MemtoReg,MemRead,MemWrite;
wire [1:0] ALUSelSrc1;
wire [1:0] ALUSelSrc2;
wire [31:0] IF_instr;
wire [31:0] pc_add4;


//Pipeline Signals
//IFID
wire [31:0] IFID_pc_o;
wire [31:0] IFID_instr_o;
wire IFID_write;
wire IFID_flush = 0;
wire [31:0]IFID_pc_add4_o;
//IDEXE
wire [1:0] IDEXE_WB_i;
wire [2:0] IDEXE_Mem_i;
wire [2:0] IDEXE_Exe_i;
wire [31:0] IDEXE_instr_o;
wire [1:0] IDEXE_WB_o;
wire [2:0] IDEXE_Mem_o;
wire [2:0] IDEXE_Exe_o;
wire [31:0] IDEXE_pc_o;
wire [31:0] IDEXE_RSdata_o;
wire [31:0] IDEXE_RTdata_o;
wire [31:0] IDEXE_ImmGen_o;
wire [3:0] IDEXE_instr_30_14_12_o;
wire [4:0] IDEXE_instr_11_7_o;
wire [31:0]IDEXE_pc_add4_o;

//EXEMEM
wire [31:0] EXEMEM_instr_o;
wire [1:0] EXEMEM_WB_o;
wire [2:0] EXEMEM_Mem_o;
wire [31:0] EXEMEM_pcsum_o;
wire EXEMEM_zero_o;
wire [31:0] EXEMEM_ALUresult_o;
wire [31:0] EXEMEM_RTdata_o;
wire [4:0]  EXEMEM_instr_11_7_o;
wire [31:0] EXEMEM_pc_add4_o;

//MEMWB
wire [1:0] MEMWB_WB_o;
wire [31:0] MEMWB_DM_o;
wire [31:0] MEMWB_ALUresult_o;
wire [4:0]  MEMWB_instr_11_7_o;
wire [31:0] MEMWB_pc_add4_o;

assign IDEXE_WB_i  = {RegWrite, MemtoReg};
assign IDEXE_Mem_i = {Branch, MemRead, MemWrite};
assign IDEXE_Exe_i = {ALUOp, ALUSrc};


//Create componentes
///    IF
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
		.PCWrite(PC_write),
	    .pc_i(pc_add4),   
	    .pc_o(pc_o) 
	    );

Adder PC_plus_4_Adder(
        pc_o,
        4,
        pc_add4
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(IF_instr)    
	    );




IF_register IFtoID(
        clk_i,
        rst_i,
        IFID_write,
        pc_o,
        IF_instr,
        pc_add4,
        IFID_pc_o,
        IFID_instr_o,
        IFID_flush,
        IFID_pc_add4_o
     );

/////// ID
Hazard_detection Hazard_detection_obj(
        IFID_instr_o[19:15],
        IFID_instr_o[24:20],
        IDEXE_instr_11_7_o,
        IDEXE_Mem_o[1],
        PC_write,
        IFID_write,
        control_output_select
);


Decoder Decoder(
        .nopsignal(control_output_select),
        .instr_i(IFID_instr_o), 
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp),
		.Jump(Jump)
	    );

	 
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(IFID_instr_o[19:15]) ,  
        .RTaddr_i(IFID_instr_o[24:20]) ,  
        .RDaddr_i(MEMWB_instr_11_7_o) ,  
        .RDdata_i(MuxMemtoReg_o)  , 
        .RegWrite_i (MEMWB_WB_o[1]),
        .RSdata_o(RSdata_o),  
        .RTdata_o(RTdata_o)   
        );
		
Imm_Gen ImmGen(
        IFID_instr_o,
        Imm_Gen_o
		);




EXE_register IDtoEXE(
        clk_i,
        rst_i,
        IFID_instr_o,
        IDEXE_WB_i,
        IDEXE_Mem_i, 
        IDEXE_Exe_i,
        RSdata_o,
        RTdata_o,
        Imm_Gen_o,
        {IFID_instr_o[30], IFID_instr_o[14:12]},
        IFID_instr_o[11:7],
        IFID_pc_o,
        IFID_pc_add4_o, //13
        IDEXE_instr_o,
        IDEXE_WB_o,
        IDEXE_Mem_o,
        IDEXE_Exe_o,
        IDEXE_RSdata_o,
        IDEXE_RTdata_o,
        IDEXE_ImmGen_o,
        IDEXE_instr_30_14_12_o,
        IDEXE_instr_11_7_o,
        IDEXE_pc_o,
        IDEXE_pc_add4_o //24
    );	
		
	
/////// EXE
Adder PC_plus_immi(
        IDEXE_pc_o,
        IDEXE_ImmGen_o,
        pc_add_immediate
	    );

MUX_2to1 Mux_ALUSrc(
        MuxALUSrc_o,
        IDEXE_ImmGen_o,
        IDEXE_Exe_o[0],
        ALUSrc2_o
		);

ForwardingUnit FWUnit(
        IDEXE_instr_o[19:15],
        IDEXE_instr_o[24:20],
        EXEMEM_instr_11_7_o,
        EXEMEM_WB_o[1],
        MEMWB_instr_11_7_o,
        MEMWB_WB_o[1],
        ALUSelSrc1,
        ALUSelSrc2
		);
		
		
MUX_3to1 MUX_ALU_src1(
        IDEXE_RSdata_o,
        MuxMemtoReg_o,
        EXEMEM_ALUresult_o,
        ALUSelSrc1,
        ALUSrc1_o
		);

MUX_3to1 MUX_ALU_src2(
        IDEXE_RTdata_o,
        MuxMemtoReg_o,
        EXEMEM_ALUresult_o,
        ALUSelSrc2,
        MuxALUSrc_o
		);
			
ALU_Ctrl ALU_Ctrl(
        IDEXE_instr_30_14_12_o,
        IDEXE_Exe_o[2:1],
        ALU_Ctrl_o
		);
		
		
alu alu(
        rst_i,
        ALUSrc1_o,
        ALUSrc2_o,
        ALU_Ctrl_o,
        ALUresult,
        zero,
        cout,
        ovf
		);

MEM_register EXEtoMEM(
        clk_i,
        rst_i,
        IDEXE_instr_o,
        IDEXE_WB_o,
        IDEXE_Mem_o,
        zero,
        ALUresult,
        MuxALUSrc_o,
        IDEXE_instr_11_7_o,
        pc_add_immediate,
        IDEXE_pc_add4_o, // 11
        EXEMEM_instr_o,
        EXEMEM_WB_o,
        EXEMEM_Mem_o,
        EXEMEM_zero_o,
        EXEMEM_ALUresult_o,
        EXEMEM_RTdata_o,
        EXEMEM_instr_11_7_o,
        EXEMEM_pcsum_o,
        EXEMEM_pc_add4_o //20
    );

//MEM		
Data_Memory Data_Memory(
        clk_i,
        EXEMEM_ALUresult_o,
        EXEMEM_RTdata_o,
        EXEMEM_Mem_o[1],
        EXEMEM_Mem_o[0],
        DM_o
		);
		
WB_register MEMtoWB(
        clk_i,
        rst_i,
        EXEMEM_WB_o,
        DM_o,
        EXEMEM_ALUresult_o,
        EXEMEM_instr_11_7_o,
        EXEMEM_pc_add4_o,
        MEMWB_WB_o,
        MEMWB_DM_o,
        MEMWB_ALUresult_o,
        MEMWB_instr_11_7_o,
        MEMWB_pc_add4_o
     );
		
/// WB
MUX_2to1 Mux_MemtoReg(
        MEMWB_ALUresult_o,
        MEMWB_DM_o,
        MEMWB_WB_o[0],
        MuxMemtoReg_o
		);



endmodule
		  


