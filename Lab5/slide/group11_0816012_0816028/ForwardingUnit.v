module ForwardingUnit (EXE_instr19_15, EXE_instr24_20, EXMEM_instr11_7, EXMEM_WBControl, MEMWB_instr11_7, MEMWB_Control, src1_sel_o, src2_sel_o);

	input [5-1:0] EXE_instr19_15; //rs1
	input [5-1:0] EXE_instr24_20; //rs2
	input [5-1:0] EXMEM_instr11_7;  //Mem rd
	input [5-1:0] MEMWB_instr11_7;   //WB rd
	input EXMEM_WBControl;
	input MEMWB_Control;
	output wire [2-1:0] src1_sel_o; 
	output wire [2-1:0] src2_sel_o;

assign src2_sel_o =  ( EXMEM_WBControl && (EXMEM_instr11_7 != 0) && (EXMEM_instr11_7 == EXE_instr24_20) ) ? 2:
                     ( (!( EXMEM_WBControl && (EXMEM_instr11_7 != 0) && (EXMEM_instr11_7 == EXE_instr24_20) )) && MEMWB_Control && (MEMWB_instr11_7 != 0) && (MEMWB_instr11_7 == EXE_instr24_20) ) ? 1 : 0;

assign src1_sel_o =  ( EXMEM_WBControl && (EXMEM_instr11_7 != 0) && (EXMEM_instr11_7 == EXE_instr19_15) ) ? 2:
                     ( (! ( EXMEM_WBControl && (EXMEM_instr11_7 != 0) && (EXMEM_instr11_7 == EXE_instr19_15) )) && MEMWB_Control && (MEMWB_instr11_7 != 0) && (MEMWB_instr11_7 == EXE_instr19_15) ) ? 1 : 0;

endmodule
 
