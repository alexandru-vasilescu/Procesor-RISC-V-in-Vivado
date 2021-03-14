`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 12:21:55 AM
// Design Name: 
// Module Name: MEM_WB_pipe
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


module MEM_WB_pipe(input clk,write,reset,
           input[31:0] Read_data_mem,
           input[31:0] ALU_out_mem,
           input[4:0] RD_MEM,
           input MemToReg_MEM, RegWrite_MEM,
           
           
           output reg[31:0] Read_data_wb,
           output reg[31:0] ALU_out_wb,
           output reg[4:0] RD_WB,
           output reg MemToReg_WB, RegWrite_WB
    );
    
    always@(posedge clk) begin
        if (reset) begin
          Read_data_wb <= 32'b0;
          ALU_out_wb <= 32'b0;
          RD_WB <= 5'b0;
          MemToReg_WB <= 0;
          RegWrite_WB <= 0;
        end
        else begin
          if(write) begin
              Read_data_wb <= Read_data_mem;
              ALU_out_wb <= ALU_out_mem;
              RD_WB <= RD_MEM;
              MemToReg_WB <= MemToReg_MEM;
              RegWrite_WB <= RegWrite_MEM;
          end
        end
  end
endmodule
