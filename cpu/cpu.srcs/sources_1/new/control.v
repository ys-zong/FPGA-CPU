`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 20:16:29
// Design Name: 
// Module Name: control
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


module control(
    //input clk,
    input rst,
    input alu_zero,//减法标志,零标志位
    input [31 : 0] imem,
    //output PC_CLK,    
    // output IM_R,     
    output reg [1 : 0] M1,//0为j和jal跳转，1为正常加4，2为beq和bne时的跳转，3为jr跳转       
    output reg [1 : 0] M2, //决定将什么数据传入寄存器组Write Data端，1为ALU结果，0为Rt，3为jal对应的npc
    output reg M3,        
    output reg [1 : 0] M4,      
    //output reg M5,        
    output reg [1 : 0] M6,   //指令读取时判断是rt还是rd进入寄存器组的写数据端，1为rt，0为rd,2为jal对应的31号寄存器        
    output reg [3 : 0] ALUC,
    output reg RF_W,     
    //output reg RF_CLK,   
    output reg DM_W,   
    output reg DM_R,     
    output reg CS,
    output reg PC_ENA
    );
    
    always @ (*)
        begin
            if(rst)
            begin
            M1 = 0;
            M2 = 0;        
            M3 = 0;        
            M4 =2'b0;      
            //M5 = 0;        
            M6 = 0;      
            ALUC = 4'b0;
            RF_W = 0;
            
            //RF_CLK = 0; 
            DM_W = 0;
            DM_R = 0;   
            CS = 0;
            PC_ENA = 0;
            end
            else
            begin
            M1[0] = ~(imem[25]&&(alu_zero) || imem[26]&&(~alu_zero) || imem[29] || imem[30]);//~(i_beq&&zero || i_bne&&(~zero) || i_j || i_jal);
            M1[1] =  imem[16] || (imem[25]&&(alu_zero)) || (imem[26]&&(~alu_zero)) ;   //i_jr || i_beq&&zero || i_bne&&(~zero);
            M2[0] = ~imem[23] /*&& ~imem[16]*/;// ~LW
            M2[1] = imem[30] /*|| imem[16]*/;//jal
            M3 = ~(imem[10] || imem[11] || imem[12] );//~(sll+srl+sra+jr)X-----~(sll+srl+sra)
            M4[0] = imem[20] || imem[19] || imem[21] || imem[22] || imem[28];//   ORI+ANDI+XORI+LUI+SLTUI
            M4[1] = imem[18] || imem[17] || imem[23] || imem[24] || imem[27]; //  ADDIU+ADDI+LW+SW+SLTI
            //M5 = (imem[25] & ~alu_zero) || (imem[26] & alu_zero);//BEQ&~0 +BNE&0
            M6[0] = imem[17] || imem[18] || imem[19] || imem[20] || imem[21] || imem[22] || imem[23] || imem[25] || imem[26] || imem[27] || imem[28];
               //ADDI+ADDIU+ORI+ANDI+XORI+LUI+LW+BEQ+BNE+SLTI+SLTIU
            M6[1] = imem[30] || imem[25] || imem[26];//i_jal || i_bne || i_beq;

            ALUC[0] = imem[2] || imem[3] || imem[5] || imem[7] || imem[8] || imem[11] || imem[14] || imem[20] || imem[25] || imem[26] || imem[27];
               //SUBU+SUB+OR+NOR+SLT+SRL+SRLV+ORI+BEQ+BNE+SLTI
            ALUC[1] = imem[0] || imem[2] || imem[6] || imem[7] || imem[8] || imem[9] || imem[10] || imem[13] || imem[17] || imem[21] || imem[23] || imem[24] || imem[25] || imem[26] || imem[27] || imem[28];
               //ADD+SUB+XOR+NOR+SLT+SLTU+SLL+SLLV+ADDI+XORI+LW+SW+BEQ+BNE+SLTI+SLTIU    
            ALUC[2] = imem[4] || imem[5] || imem[6] || imem[7] || imem[10] || imem[11] || imem[12] || imem[13] || imem[14] || imem[15] || imem[19] || imem[20] || imem[21];
               //AND+OR+XOR+NOR +SLL+SRL+SRA+SLLV+SRLV+SRAV+ORI+ANDI+XORI
            ALUC[3] = imem[8] || imem[9] || imem[10] || imem[11] || imem[12] || imem[13] || imem[14] || imem[15] || imem[22] || imem[27] || imem[28];
               //SLT+SLTU+SLL+SRL+SRA+SLLV+SRLV+SRAV +LUI+SLTI+SLTIU
           
            RF_W = ~(imem[16] || imem[24] || imem[25] || imem[26] || imem[29]);
               //~(JR+SW+BEQ+BNE+J)
            //RF_CLK = ~clk;//?
            DM_W = imem[24];//SW
            DM_R = imem[23];//LW
            CS = imem[23] || imem[24];//LW+SW
              
            PC_ENA = (imem[31 : 26]==5'h1f) ? 0 : 1; 
            end
        end
    
endmodule
