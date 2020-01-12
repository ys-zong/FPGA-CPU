`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 19:49:31
// Design Name: 
// Module Name: MUX1
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


module MUX1(
    input [31 : 0] II,//00
    input [31 : 0] npc,//01
    input [31 : 0] mux5,//10
    input [31 : 0] rS,//11
    input [1 : 0] M1,
    output reg [31 : 0] to_pc
    );
    always @(*)
    begin
    case(M1)
        2'b00: to_pc = II;
        2'b01: to_pc = npc;
        2'b10: to_pc = mux5;     
        2'b11: to_pc = rS;
        default:
        to_pc = 32'bz;//zzzzzzz
   endcase
   end
endmodule
