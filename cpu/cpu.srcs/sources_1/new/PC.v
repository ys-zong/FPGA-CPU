`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/03 09:48:44
// Design Name: 
// Module Name: PC
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
/*
module PC(
     input clk,//上升沿时为寄存器赋值
     input rst,//异步重置，高电平清零
     input ena,//高电平读入data_in，否则保持原有输出
     input [31 : 0] data_in,//
     output [31 : 0] data_out
    );
    D_FF uut1(clk,rst,ena,data_in[0],data_out[0]);
    D_FF uut2(clk,rst,ena,data_in[1],data_out[1]);
    D_FF uut3(clk,rst,ena,data_in[2],data_out[2]);
    D_FF uut4(clk,rst,ena,data_in[3],data_out[3]);
    D_FF uut5(clk,rst,ena,data_in[4],data_out[4]);
    D_FF uut6(clk,rst,ena,data_in[5],data_out[5]);
    D_FF uut7(clk,rst,ena,data_in[6],data_out[6]);
    D_FF uut8(clk,rst,ena,data_in[7],data_out[7]);
    D_FF uut9(clk,rst,ena,data_in[8],data_out[8]);
    D_FF uut10(clk,rst,ena,data_in[9],data_out[9]);
    D_FF uut11(clk,rst,ena,data_in[10],data_out[10]);
    D_FF uut12(clk,rst,ena,data_in[11],data_out[11]);
    D_FF uut13(clk,rst,ena,data_in[12],data_out[12]);
    D_FF uut14(clk,rst,ena,data_in[13],data_out[13]);
    D_FF uut15(clk,rst,ena,data_in[14],data_out[14]);
    D_FF uut16(clk,rst,ena,data_in[15],data_out[15]);
    D_FF uut17(clk,rst,ena,data_in[16],data_out[16]);
    D_FF uut18(clk,rst,ena,data_in[17],data_out[17]);
    D_FF uut19(clk,rst,ena,data_in[18],data_out[18]);
    D_FF uut20(clk,rst,ena,data_in[19],data_out[19]);
    D_FF uut21(clk,rst,ena,data_in[20],data_out[20]);
    D_FF uut22(clk,rst,ena,data_in[21],data_out[21]);
    D_FF uut23(clk,rst,ena,data_in[22],data_out[22]);
    D_FF uut24(clk,rst,ena,data_in[23],data_out[23]);
    D_FF uut25(clk,rst,ena,data_in[24],data_out[24]);
    D_FF uut26(clk,rst,ena,data_in[25],data_out[25]);
    D_FF uut27(clk,rst,ena,data_in[26],data_out[26]);
    D_FF uut28(clk,rst,ena,data_in[27],data_out[27]);
    D_FF uut29(clk,rst,ena,data_in[28],data_out[28]);
    D_FF uut30(clk,rst,ena,data_in[29],data_out[29]);
    D_FF uut31(clk,rst,ena,data_in[30],data_out[30]);
    D_FF uut32(clk,rst,ena,data_in[31],data_out[31]);
endmodule
*/


module PC(
    input clk, 
    input reset, 
    input pcreg_ena,
    input [31 : 0] data_in,  // 从指令中取出进行符号扩展后得来的
    output reg [31 : 0] data_out
    );           

    always@(negedge clk or negedge reset) 
    begin
        if(reset)
        begin
            data_out<=32'h00400000;
        end 
        else if(pcreg_ena)
            data_out<=data_in;
        /*begin
            if(pcreg_ena)
                data_out<=data_in;
            else;
        end*/
    end
endmodule

