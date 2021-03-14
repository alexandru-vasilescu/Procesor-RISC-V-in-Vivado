`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 09:40:38 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
    reg [31:0] data[0:1023];
    integer i;
    initial begin
        for(i = 0; i < 1024; i = i + 1)
            data[i] = 0;
    end
    reg [31:0] add;
    always @(*) begin
        add = address >> 2;
        if (mem_read == 1)
            read_data = data[add];
    end
    always @(posedge clk) begin
        if (mem_write == 1)
            data[add] = write_data;
    end
endmodule
