`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 09:51:10 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(input [4:0] rd,
                        input [4:0] rs1,
                        input [4:0] rs2,
                        input MemRead,
                        output reg PCwrite,
                        output reg IF_IDwrite,
                        output reg control_sel);
                        
    always @(*) begin
        if(MemRead == 1 && ((rd == rs1) || (rd == rs2))) begin
            control_sel = 1;
            PCwrite = 0;
            IF_IDwrite = 0;     
        end
        else begin
            control_sel = 0;
            PCwrite = 1;
            IF_IDwrite = 1;
        end
    end        
endmodule
