`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 08:53:33 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input[3:0] ALUop,
            input[31:0] ina, inb,
            output zero,
            output reg [31:0] out);
            
    reg [32:0] a,b;
    reg aux;
    initial begin
        out = 32'b0;
        aux = 1;
    end
            
    always @(*) begin

        out = 32'b0;
        if (ALUop == 4'b0010)
            out = ina + inb; //add
            
        if (ALUop == 4'b0110)
            out = ina - inb; //sub
            
        if (ALUop == 4'b0000)
            out = ina & inb; //and
            
        if (ALUop == 4'b0001)
            out = ina | inb; //or
            
        if (ALUop == 4'b0011)
            out = ina ^ inb; //xor
            
        if (ALUop == 4'b0101)
            out = ina >> inb; //srl
            
        if (ALUop == 4'b0100)
            out = ina << inb; //sll
            
        if (ALUop == 4'b1001)
            out = ina >>> inb; // sra
            
        if (ALUop == 4'b0111) //slt
            if (ina > inb)
                out = 0;
            else
                out = 1;
        if (ALUop == 4'b1000) begin
            a = {0,ina};
            b = {0,inb};
            if (a > b)
                out = 32'b0;
            else
                out = {31'b0, 1'b1};
        end
        if(out == 0)
            aux = 1;
        else 
            aux = 0;
    end
    assign zero = aux;
    
endmodule
