`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2021 10:56:56 PM
// Design Name: 
// Module Name: test
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


module test;
  reg clk,reset;
  reg IF_ID_write;
  reg PCSrc,PC_write;
  reg [31:0] PC_Branch;
  reg RegWrite_WB; 
  reg [31:0] ALU_DATA_WB;
  reg [4:0] RD_WB;
  reg control_sel;
  wire [31:0] PC_ID;
  wire [31:0] INSTRUCTION_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID,REG_DATA2_ID;
  wire [2:0] FUNCT3_ID;
  wire [6:0] FUNCT7_ID;
  wire [6:0] OPCODE_ID;
  wire [4:0] RD_ID;
  wire [4:0] RS1_ID;
  wire [4:0] RS2_ID;
  wire RegWrite_ID;  //semnal pentru scrierea in bancul de registri
wire MemtoReg_ID;  //semnal pentru scrierea din memorie in registru
wire MemRead_ID;  //semnal pentru citirea din memoria de date
wire MemWrite_ID;  //semnal pentru scrierea in memoria de date
wire [1:0] ALUop_ID; //codificarea operatiei efectuate de ALU 
wire ALUSrc_ID;      //semnal pentru alegerea operanzilor in ALU
wire Branch_ID;

RISC_V_IF_ID procesor(clk,reset,
        IF_ID_write,
        PCSrc,PC_write,
        PC_Branch,
        RegWrite_WB, 
         ALU_DATA_WB,
         RD_WB,
         control_sel,
         PC_ID,
         INSTRUCTION_ID,
         IMM_ID,
         REG_DATA1_ID,REG_DATA2_ID,
         FUNCT3_ID,
         FUNCT7_ID,
         OPCODE_ID,
         RD_ID,    
         RS1_ID,   
         RS2_ID,
         RegWrite_ID,  //semnal pentru scrierea in bancul de registri
         MemtoReg_ID,  //semnal pentru scrierea din memorie in registru
         MemRead_ID,   //semnal pentru citirea din memoria de date
         MemWrite_ID,  //semnal pentru scrierea in memoria de date
         ALUop_ID, //codificarea operatiei efectuate de ALU 
         ALUSrc_ID,      //semnal pentru alegerea operanzilor in ALU
         Branch_ID);    
  
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
       IF_ID_write = 1'b1;      
       PCSrc = 1'b0;
       PC_write = 1'b1;    
       PC_Branch = 32'b0;  
       RegWrite_WB = 1'b0;       
       ALU_DATA_WB = 32'b0;
       RD_WB = 5'b0;   
       control_sel = 1'b0;        
       
    #10 reset=1'b0;
    #200 $finish;
  end
endmodule
