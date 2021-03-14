`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2021 12:13:04 AM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
             );
    
        wire IF_ID_write, PCSrc_IF_ID, PC_write_IF_ID, RegWrite_WB, control_sel;
        wire [31:0] PC_Branch_IF_ID, PC_ID, INSTRUCTION_ID, IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
        wire [4:0] RD_WB, RD_ID, RS1_ID, RS2_ID;
        wire [2:0] FUNCT3_ID;
        wire [6:0] FUNCT7_ID;
        wire [6:0] OPCODE_ID;
        wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUSrc_ID, Branch_ID;
        wire [1:0] ALUop_ID;
        
        wire[31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX;
        wire[2:0] FUNCT3_EX;
        wire[6:0] FUNCT7_EX;
        wire[6:0] OPCODE_EX;
        wire[4:0] RD_EX, RS1_EX, RS2_EX;
        wire RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX;
        wire[1:0] ALUop_EX;
        wire ALUSrc_EX;
        wire Branch_EX;
        
        wire ZERO_EX;
        wire[31:0] REG_DATA2_EX_FINAL;
        wire[31:0] PC_Branch_EX;
        wire[31:0] ALU_OUT_MEM;
        
        wire ZERO_MEM;
        wire [31:0] ALU_OUT_MEM, REG_DATA2_MEM_FINAL;
        wire [4:0] RD_MEM;
        wire RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM;
        
        wire [31:0] Read_data_wb;
        wire [31:0] ALU_out_wb;
        wire MemtoReg_WB;
        
        
        
        RISC_V_IF_ID if_id(clk, reset, 
                            IF_ID_write,
                            PCSrc, 
                            PC_write_IF_ID,
                            PC_Branch_IF_ID, 
                            RegWrite_WB,
                            ALU_DATA_WB,
                            RD_WB,
                            control_sel,
                            
                            PC_ID,
                            INSTRUCTION_ID,
                            IMM_ID,
                            REG_DATA1_ID,
                            REG_DATA2_ID,
                            
                            FUNCT3_ID,
                            FUNCT7_ID,
                            OPCODE_ID,
                            RD_ID,
                            RS1_ID,
                            RS2_ID,
                            RegWrite_ID,
                            MemtoReg_ID,
                            MemRead_ID,
                            MemWrite_ID,
                            ALUop_ID,
                            ALUSrc_ID,
                            Branch_ID);
                            
        ID_EX_pipe idex(clk, IF_ID_write, reset, 
                        IMM_ID, REG_DATA1_ID, REG_DATA2_ID, PC_ID,
                        FUNCT3_ID,
                        FUNCT7_ID,
                        OPCODE_ID,
                        RD_ID,
                       RS1_ID,
                       RS2_ID,
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                       ALUop_ID,
                       ALUSrc_ID,
                       Branch_ID,
                       IMM_EX,
                       REG_DATA1_EX,REG_DATA2_EX, PC_EX,
                       FUNCT3_EX,
                       FUNCT7_EX,
                       OPCODE_EX,
                       RD_EX,
                       RS1_EX,
                       RS2_EX,
                       RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,
                       ALUop_EX,
                       ALUSrc_EX,
                       Branch_EX);
                                           
        hazard_detection hd(RD_EX, RS1_ID, RS2_ID, MemRead_EX,
                            PC_write_IF_ID, IF_ID_write, control_sel);  
                            
        assign pipeline_stall = control_sel;
        
        EX execute(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX,
                    FUNCT3_EX, FUNCT7_EX, RD_EX, RS1_EX, RS2_EX,
                    RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
                    ALUop_EX, ALUSrc_EX, Branch_EX, forwardA, forwardB,
                    ALU_DATA_WB, ALU_OUT_MEM,
                    ZERO_EX, ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL);
                    
        EX_MEM_pipe exmem(clk, IF_ID_write, reset, ZERO_EX, ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL, RD_EX,
                          RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX,
                          ZERO_MEM, ALU_OUT_MEM, PC_MEM, REG_DATA2_MEM_FINAL, RD_MEM,
                          RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM);
        
        MEM m(clk, PC_MEM, Branch_MEM, ZERO_MEM, ALU_OUT_MEM, REG_DATA2_MEM_FINAL, RD_MEM,
              RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM,
              PC_Branch_IF_ID, PCSrc, DATA_MEMORY_MEM
              );
              
        MEM_WB_pipe memwb(clk, IF_ID_write, reset, DATA_MEMORY_MEM, ALU_OUT_MEM, RD_MEM,
                          MemtoReg_MEM, RegWrite_MEM,
                          Read_data_wb, ALU_out_wb, RD_WB, 
                          MemtoReg_WB, RegWrite_WB);
        
        forwarding f(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_MEM, RegWrite_WB,
                    forwardA, forwardB);
                                     
        mux2_1 wb(ALU_out_wb, Read_data_wb, MemtoReg_WB, ALU_DATA_WB);
        
        
endmodule
