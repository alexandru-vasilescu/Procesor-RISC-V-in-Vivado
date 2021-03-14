`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:14:47 PM
// Design Name: 
// Module Name: MUX_3_1
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


module MUX_3_1(input[31:0] ina,inb,inc,
                input[1:0] sel,
                output[31:0] out);
        
        assign out = (sel[1] == 1'b1) ? inc : (sel[0] == 1'b1 ? inb : ina);
                    
endmodule
