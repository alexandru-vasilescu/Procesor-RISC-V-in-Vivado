`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 12:06:34 AM
// Design Name: 
// Module Name: ID_EX_pipe
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


module ID_EX_pipe(input clk,write,reset,
          input [31:0] IMM_ID,
          input [31:0] REG_DATA1_ID,REG_DATA2_ID,
          input [31:0] PC_ID,
          input [2:0] FUNCT3_ID,
          input [6:0] FUNCT7_ID,
          input [6:0] OPCODE_ID,
          input [4:0] RD_ID,
          input [4:0] RS1_ID,
          input [4:0] RS2_ID,
          input RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
          input [1:0] ALUop_ID,
          input ALUSrc_ID,
          input Branch_ID,
          output reg[31:0] IMM_EX,
          output reg[31:0] REG_DATA1_EX,REG_DATA2_EX,
          output reg[31:0] PC_EX,
          output reg[2:0] FUNCT3_EX,
          output reg[6:0] FUNCT7_EX,
          output reg[6:0] OPCODE_EX,
          output reg[4:0] RD_EX,
          output reg[4:0] RS1_EX,
          output reg[4:0] RS2_EX,
          output reg RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,
          output reg[1:0] ALUop_EX,
          output reg ALUSrc_EX,
          output reg Branch_EX);
          
    always@(posedge clk) begin
        if (reset) begin
              IMM_EX<=32'b0;
              REG_DATA1_EX<=32'b0;
              REG_DATA2_EX<=32'b0;
              PC_EX <= 32'b0;
              FUNCT3_EX <= 3'b0;
              FUNCT7_EX <= 7'b0;
              OPCODE_EX <= 7'b0;
              RD_EX <= 5'b0;
              RS1_EX <= 5'b0;
              RS2_EX <= 5'b0;
              RegWrite_EX <= 0;
              MemtoReg_EX <= 0;
              MemRead_EX <= 0;
              MemWrite_EX <= 0;
              ALUop_EX <= 2'b0;
              ALUSrc_EX <= 0;
              Branch_EX <= 0;
        end
        else begin
          if(write) begin
              IMM_EX<=IMM_ID;
              REG_DATA1_EX<=REG_DATA1_ID;
              REG_DATA2_EX<=REG_DATA2_ID;
              PC_EX <= PC_ID;
              FUNCT3_EX <= FUNCT3_ID;
              FUNCT7_EX <= FUNCT7_ID;
              OPCODE_EX <= OPCODE_ID;
              RD_EX <= RD_ID;
              RS1_EX <= RS1_ID;
              RS2_EX <= RS2_ID;
              RegWrite_EX <= RegWrite_ID;
              MemtoReg_EX <= MemtoReg_ID;
              MemRead_EX <= MemRead_ID;
              MemWrite_EX <= MemWrite_ID;
              ALUop_EX <= ALUop_ID;
              ALUSrc_EX <= ALUSrc_ID;
              Branch_EX <= Branch_ID;
          end
        end
    end
endmodule
