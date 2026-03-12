`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2026 02:44:39 PM
// Design Name: 
// Module Name: tb
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
module tb_rv32i_pipeline();
reg clk;
reg rst_n;
wire [31:0] final_wb_data_out;

rv32i_top uut (
.clk(clk),
.rst_n(rst_n),
.final_wb_data(final_wb_data_out)
);

always #5 clk = ~clk;
initial begin
clk = 0;
rst_n = 0;
#15;
rst_n = 1;
#250;

$display("==================================================");
$display("Pipeline Simulation Complete");
$display("==================================================");
$display("Register x1 (Expected: 15): %d", uut.rf.regs[1]);
$display("Register x2 (Expected:  5): %d", uut.rf.regs[2]);
$display("Register x3 (Expected: 10): %d", uut.rf.regs[3]);  // 15 - 5
$display("Register x4 (Expected: 15): %d", uut.rf.regs[4]);  // 15 | 5
$display("Register x5 (Expected:  5): %d", uut.rf.regs[5]);  // 15 & 5
$display("Register x6 (Expected:  1): %d", uut.rf.regs[6]);  // 5 < 15 (slt)
$display("Register x7 (Expected: 10): %d", uut.rf.regs[7]);  // Loaded from mem
$display("Register x8 (Expected:  0): %d", uut.rf.regs[8]);  
$display("Register x9 (Expected:  1): %d", uut.rf.regs[9]);  
$display("Data Mem[8] (Expected: 10): %d", uut.dmem.ram[2]); 
$display("==================================================");
$finish;
end
endmodule 