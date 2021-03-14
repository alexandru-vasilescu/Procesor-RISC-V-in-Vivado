`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 12:16:20 AM
// Design Name: 
// Module Name: EX_MEM_pipe
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


module EX_MEM_pipe(input clk,write,reset,
          input ZERO_EX,
          input [31:0] ALU_OUT_EX,
          input [31:0] PC_Branch_EX,
          input [31:0] REG_DATA2_EX_FINAL,
          input [4:0] RD_EX,
          input RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX,
          
          output reg ZERO_MEM,
          output reg[31:0] ALU_OUT_MEM,
          output reg[31:0] PC_Branch_MEM,
          output reg[31:0] REG_DATA2_MEM_FINAL,
          output reg[4:0] RD_MEM,
          output reg RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM
    );
    
    always@(posedge clk) begin
        if (reset) begin
            ZERO_MEM <= 0;
            ALU_OUT_MEM <= 32'b0;
            PC_Branch_MEM <= 32'b0;
            REG_DATA2_MEM_FINAL <= 32'b0;
            RD_MEM <= 5'b0;
            RegWrite_MEM <= 0;
            MemtoReg_MEM <= 0;
            MemRead_MEM <= 0;
            MemWrite_MEM <= 0;
            Branch_MEM <= 0;
        end
        else begin
          if(write) begin
            ZERO_MEM <= ZERO_EX;
            ALU_OUT_MEM <= ALU_OUT_EX;
            PC_Branch_MEM <= PC_Branch_EX;
            REG_DATA2_MEM_FINAL <= REG_DATA2_EX_FINAL;
            RD_MEM <= RD_EX;
            RegWrite_MEM <= RegWrite_EX;
            MemtoReg_MEM <= MemtoReg_EX;
            MemRead_MEM <= MemRead_EX;
            MemWrite_MEM <= MemWrite_EX;
            Branch_MEM <= Branch_EX;
          end
        end
  end
endmodule
