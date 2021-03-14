`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 09:21:16 PM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA,forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_DATA_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );
          
          wire [3:0] ALUinput;
          wire [31:0] data1, data2;
          ALUcontrol ac(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
          
          MUX_3_1 m1(REG_DATA1_EX, ALU_DATA_WB, ALU_DATA_MEM, forwardA, data1);
          
          MUX_3_1 m2(REG_DATA2_EX, ALU_DATA_WB, ALU_DATA_MEM, forwardB, REG_DATA2_EX_FINAL);
          
          mux2_1 m3(REG_DATA2_EX_FINAL, IMM_EX, ALUSrc_EX, data2);
          
          ALU a(ALUinput, data1, data2, ZERO_EX, ALU_OUT_EX);
          
          adder sum(PC_EX,IMM_EX,PC_Branch_EX);
endmodule
