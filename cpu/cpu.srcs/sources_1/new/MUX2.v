`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 20:09:13
// Design Name: 
// Module Name: MUX2
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


module MUX2(
    input [31 : 0] in_dmem,//0
    input [31 : 0] in_alu,//1    
    input [31 : 0] in_none,//2
    input [31 : 0] in_add2,//3
    input [1 : 0] M2,
    output reg [31 : 0] to_regfile
    );
    always @(*)
    begin
    case(M2)
        2'b01: to_regfile = in_alu;
        2'b00: to_regfile = in_dmem;
        2'b10: to_regfile = 32'b0;
        2'b11: to_regfile = in_add2;      
        default:
        to_regfile = 32'bz;//zzzzzz
    endcase
    end
endmodule
