`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:46:42 PM
// Design Name: 
// Module Name: MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM(input clk,
           input[31:0] PC_MEM,
           input Branch_Mem,
           input ALU_ZERO,
           input[31:0] ALU_RESULT,
           input[31:0] REG_DATA2_EX_FINAL,
           input [4:0] RD_MEM,
           input RegWrite_MEM,
           input MemtoReg_MEM,
           input MemRead_MEM,
           input MemWrite_MEM,
           
           output[31:0] PC_Branch,
           output PCSrc_mem,
           output[31:0] Read_data_mem
    );
    assign PC_Branch = PC_MEM;
    assign PCSrc_mem = Branch_Mem * ALU_ZERO;
    data_memory dm(clk,MemRead_MEM,MemWrite_MEM,ALU_RESULT,REG_DATA2_EX_FINAL,Read_data_mem);
endmodule
