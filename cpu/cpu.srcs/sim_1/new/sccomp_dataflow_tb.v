`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 20:05:43
// Design Name: 
// Module Name: sccomp_dataflow_tb
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


module sccomp_dataflow_tb();
       reg clkin;
       reg rst;
       wire [7 : 0] o_sel;
       wire [7:0] o_seg;
       // Outputs
       //wire [31 : 0] _inst;
       //wire [31 : 0] _pc;
       //wire [31 : 0] _addr;
       //integer file_output;
       //integer counter = 0;
       initial
       begin
       //file_output = $fopen("d:/cpu_test_result/coe_result_imem.txt");
       clkin = 0; 
       rst = 1;       
       #10 rst = 0;
       end
    
       
       always 
       begin
       #12 ;
       clkin = ~clkin;
       //if(clkin == 1'b1 )
       //begin
       //if(test.sccpu.inst === 32'hxxxxxxxx)
           // $fclose(file_output);
      // else
      // begin
       //counter = counter + 1;
       /*
       $fdisplay(file_output,"pc: %h",_pc);
       $fdisplay(file_output,"instr: %h",_inst);
       
       $fdisplay(file_output,"regfile0: %h",test.sccpu.cpu_ref.array_reg[0]);
       $fdisplay(file_output,"regfile1: %h",test.sccpu.cpu_ref.array_reg[1]);
       $fdisplay(file_output,"regfile2: %h",test.sccpu.cpu_ref.array_reg[2]);
       $fdisplay(file_output,"regfile3: %h",test.sccpu.cpu_ref.array_reg[3]);
       $fdisplay(file_output,"regfile4: %h",test.sccpu.cpu_ref.array_reg[4]);
       $fdisplay(file_output,"regfile5: %h",test.sccpu.cpu_ref.array_reg[5]);
       $fdisplay(file_output,"regfile6: %h",test.sccpu.cpu_ref.array_reg[6]);
       $fdisplay(file_output,"regfile7: %h",test.sccpu.cpu_ref.array_reg[7]);
       $fdisplay(file_output,"regfile8: %h",test.sccpu.cpu_ref.array_reg[8]);
       $fdisplay(file_output,"regfile9: %h",test.sccpu.cpu_ref.array_reg[9]);
       $fdisplay(file_output,"regfile10: %h",test.sccpu.cpu_ref.array_reg[10]);
       $fdisplay(file_output,"regfile11: %h",test.sccpu.cpu_ref.array_reg[11]);
       $fdisplay(file_output,"regfile12: %h",test.sccpu.cpu_ref.array_reg[12]);
       $fdisplay(file_output,"regfile13: %h",test.sccpu.cpu_ref.array_reg[13]);
       $fdisplay(file_output,"regfile14: %h",test.sccpu.cpu_ref.array_reg[14]);
       $fdisplay(file_output,"regfile15: %h",test.sccpu.cpu_ref.array_reg[15]);
       $fdisplay(file_output,"regfile16: %h",test.sccpu.cpu_ref.array_reg[16]);
       $fdisplay(file_output,"regfile17: %h",test.sccpu.cpu_ref.array_reg[17]);
       $fdisplay(file_output,"regfile18: %h",test.sccpu.cpu_ref.array_reg[18]);
       $fdisplay(file_output,"regfile19: %h",test.sccpu.cpu_ref.array_reg[19]);
       $fdisplay(file_output,"regfile20: %h",test.sccpu.cpu_ref.array_reg[20]);
       $fdisplay(file_output,"regfile21: %h",test.sccpu.cpu_ref.array_reg[21]);
       $fdisplay(file_output,"regfile22: %h",test.sccpu.cpu_ref.array_reg[22]);
       $fdisplay(file_output,"regfile23: %h",test.sccpu.cpu_ref.array_reg[23]);
       $fdisplay(file_output,"regfile24: %h",test.sccpu.cpu_ref.array_reg[24]);
       $fdisplay(file_output,"regfile25: %h",test.sccpu.cpu_ref.array_reg[25]);
       $fdisplay(file_output,"regfile26: %h",test.sccpu.cpu_ref.array_reg[26]);
       $fdisplay(file_output,"regfile27: %h",test.sccpu.cpu_ref.array_reg[27]);
       $fdisplay(file_output,"regfile28: %h",test.sccpu.cpu_ref.array_reg[28]);
       $fdisplay(file_output,"regfile29: %h",test.sccpu.cpu_ref.array_reg[29]);
       $fdisplay(file_output,"regfile30: %h",test.sccpu.cpu_ref.array_reg[30]);
       $fdisplay(file_output,"regfile31: %h",test.sccpu.cpu_ref.array_reg[31]);
       end
       end*/
       end
       
       sccomp_dataflow test(
       .clk_in(clkin),
       .reset(rst),
       //.o_seg(o_seg),
       //.o_sel(o_sel)
       .inst(_inst),
       .pc(_pc),
       .addr(_addr)
       );
       
       //sccomp_dataflow test(clkin, rst, _inst, _pc, _addr);
endmodule
