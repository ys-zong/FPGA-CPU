`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 20:14:08
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input reset,
    input  [31 : 0] inst,//指令寄存器中获取的指令码
    input  [31 : 0] rdata,//dmem的读数据
    output [31 : 0] pc,//当前指令的地址-
    output [31 : 0] addr,//DMEM存入数据的地址
    output [31 : 0] wdata,//dmem的写数据
    //output IM_R,
    output DM_CS,
    output DM_R,
    output DM_W   
    );
  
    //--------------------------------//控制信号(除有关存储器）
    
    
    wire PC_CLK;                     //
    wire PC_ENA;                     //
    wire [1 : 0] M1;                         //
    wire [1 : 0] M2;                 //
    wire M3;                         //
    wire [1 : 0] M4;                         //
    //wire M5;                         //
    wire [1 : 0] M6;                         //
   
    wire [3 : 0] ALUC;               //
    wire RF_W;                       //
    wire RF_CLK;                     //
   
    //--------------------------------//运算标志位
    wire zero;                       //
    //wire carry;                      //
    wire negative;                   //
    wire overflow;                   //
    wire add_overflow;               //
    //--------------------------------// 
    wire [31 : 0] INS;                 //译码后指令
    //--------------------------------//数据通路（除有关存储器）
    wire [31 : 0] D_ALU;               //
    wire [31 : 0] D_PC;                //pc-output
    wire [31 : 0] D_RF;                //
    wire [31 : 0] D_Rs;                //
    wire [31 : 0] D_Rt;                //
    wire [31 : 0] D_IM;                //
    wire [31 : 0] D_DM;                //
    wire [31 : 0] D_Mux1;              //
    wire [31 : 0] D_Mux2;              //
    wire [31 : 0] D_Mux3;              //
    wire [31 : 0] D_Mux4;              //
    wire [31 : 0] D_Mux5;              //
    wire [4 : 0] D_Mux6;              //
   
    wire [31 : 0] EXT5;              //
    wire [31 : 0] S_EXT16;  
    wire [31 : 0] EXT16;
    wire [31 : 0] EXT18;             //
    wire [31 : 0] ADD1;               //
    wire [31 : 0] ADD2;              //
    wire [31 : 0] NPC;               //
    wire [31 : 0] D_II;                //
    
    //assign PC_ENA = 1;
    //--------------------------------//外部通路连接
    assign pc = D_PC;
    assign addr = D_ALU;
    assign wdata = D_Rt;
    assign D_DM = rdata;
    //
    assign PC_CLK= clk;//~
    assign RF_CLK= clk;//-
    //--------------------------------//指令
    PC   cpu_PC      (PC_CLK,     reset,      PC_ENA,      D_Mux1,   D_PC);
    //IMEM uut_IMEM    (D_PC,       IM_R,       inst  );
    instr_decoder cpu_instr_decoder (inst[31 : 26], inst[5 : 0], INS);
    control cpu_control ( reset, zero, INS, M1, M2, M3, M4,  M6, ALUC, RF_W, DM_W, DM_R, DM_CS, PC_ENA);
    //--------------------------------//部件
    
    alu     cpu_alu     (D_Mux3,     D_Mux4,    ALUC[3:0],   D_ALU,    zero,  /*carry,*/  negative, overflow);
    
    wire rf_we = (~overflow) && RF_W;
    //regfiles cpu_ref    (.clk(RF_CLK),.rst(reset), .we(rf_we), //we 高电平写入，低电平读出
    //.rtc(inst[20:16]),.rsc(inst[25:21]),.rdc(D_Mux6), .rd(D_Mux2),.rt(D_Rt),.rs(D_Rs));//rd
    
    //regfile(clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    regfile cpu_ref (.clk(RF_CLK),.rst(reset),.we(rf_we),.raddr1(inst[20:16]),.raddr2(inst[25:21]),
    .waddr(D_Mux6),.wdata(D_Mux2),.rdata1(D_Rt),.rdata2(D_Rs));
    
    MUX1    cpu_mux1   (.II(D_II), .npc(NPC), .rS(D_Rs), .mux5(ADD1), .M1(M1), .to_pc(D_Mux1) );
    MUX2    cpu_mux2   (.in_dmem(D_DM),.in_alu(D_ALU),.in_add2(/*ADD2*/NPC),.in_none(32'b0),.M2(M2),.to_regfile(D_Mux2));
    MUX3    cpu_mux3   (.ext5(EXT5), .regfile(D_Rs), .M3(M3),  .to_alu(D_Mux3));
    MUX4    cpu_mux4    (.rt(D_Rt), .ext16(EXT16),  .s_ext16(S_EXT16), .M4(M4),.to_alu(D_Mux4));
    //MUX5    cpu_mux5    (.npc(NPC),.add(ADD1),.M5(M5),.to_mux1(D_Mux5));
    MUX6    cpu_mux6   (.rdc(inst[15 : 11]),.rtc(inst[20 : 16]),.jal(5'd31),.none6(5'b0),.M6(M6),.to_regfile(D_Mux6));//有必要换成四选一吗？
   
    //Ext5 cpu_ext5    (.sa(inst[10 : 6]),.to_mux3(EXT5));
    assign EXT5 = {27'b0,inst[10 : 6]};   
    //Ext16 cpu_ext16  (.imem15_0(inst[15 : 0]),.to_mux4(EXT16));
    assign EXT16 = {{(16){1'b0}},inst[15 : 0]};
    //S_Ext16 cpu_sext16 (.simem15_0(inst[15 : 0]),.sto_mux4(S_EXT16));
    assign S_EXT16 = {{(16){inst[15]}},inst[15 : 0]};
    //Ext18 cpu_ext18  (.imem15_0_18(inst[15 : 0]), .to_mux4_18(EXT18));
    assign EXT18 = {{(14){inst[15]}},inst[15 : 0],2'b00};
    ADD   cpu_add1   (.a(NPC), .b(EXT18), .z(ADD1));//与MUX1相连
    //ADD  cpu_add2   (.a(D_PC),.b(32'd4),.z(ADD2));
    //add8    cpu_add8    (D_PC,       D_ADD8);
    npc     cpu_npc     (.pc(D_PC), .to_(NPC));
    II      cpu_II      (.pc31_28(D_PC[31 : 28]),.imem25_0(inst[25 : 0]), .to_mux1(D_II));
    //
    //assign DM_R=~DM_W;//------------看修改
    

endmodule
