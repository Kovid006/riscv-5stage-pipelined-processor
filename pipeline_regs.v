`timescale 1ns / 1ps

module if_id_reg(
input clk, rst_n,
input [31:0] pc_in, instr_in,
output reg [31:0] pc_out, instr_out
);
always @(posedge clk or negedge rst_n) begin
if (!rst_n) {pc_out, instr_out} <= 64'b0;
else {pc_out, instr_out} <= {pc_in, instr_in};
end
endmodule

module id_ex_reg(
input clk, rst_n,
input wb_reg_write_in, wb_mem_to_reg_in,
input mem_branch_in, mem_read_in, mem_write_in,
input [1:0] ex_alu_op_in, input ex_alu_src_in,
input [31:0] pc_in, reg_data1_in, reg_data2_in, imm_in,
input [4:0] rd_in,
input [2:0] funct3_in, input funct7_in,
output reg wb_reg_write_out, wb_mem_to_reg_out,
output reg mem_branch_out, mem_read_out, mem_write_out,
output reg [1:0] ex_alu_op_out,
output reg ex_alu_src_out,
output reg [31:0] pc_out, reg_data1_out, reg_data2_out, imm_out,
output reg [4:0] rd_out,
output reg [2:0] funct3_out,
output reg funct7_out
);
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wb_reg_write_out <= 0; wb_mem_to_reg_out <= 0;
mem_branch_out <= 0; mem_read_out <= 0; mem_write_out <= 0;
ex_alu_op_out <= 0; ex_alu_src_out <= 0;
pc_out <= 0; reg_data1_out <= 0; reg_data2_out <= 0; imm_out <= 0;
rd_out <= 0; funct3_out <= 0; funct7_out <= 0;
end else begin
wb_reg_write_out <= wb_reg_write_in; wb_mem_to_reg_out <= wb_mem_to_reg_in;
mem_branch_out <= mem_branch_in; mem_read_out <= mem_read_in; mem_write_out <= mem_write_in;
ex_alu_op_out <= ex_alu_op_in; ex_alu_src_out <= ex_alu_src_in;
pc_out <= pc_in; reg_data1_out <= reg_data1_in; reg_data2_out <= reg_data2_in; imm_out <= imm_in;
rd_out <= rd_in; funct3_out <= funct3_in; funct7_out <= funct7_in;
end
end
endmodule

module ex_mem_reg(
input clk, rst_n,
input wb_reg_write_in, wb_mem_to_reg_in,
input mem_branch_in, mem_read_in, mem_write_in,
input [31:0] branch_target_in, alu_result_in, reg_data2_in,
input zero_in,
input [4:0] rd_in,
output reg wb_reg_write_out, wb_mem_to_reg_out,
output reg mem_branch_out, mem_read_out, mem_write_out,
output reg [31:0] branch_target_out, alu_result_out, reg_data2_out,
output reg zero_out,
output reg [4:0] rd_out
);
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wb_reg_write_out <= 0; wb_mem_to_reg_out <= 0;
mem_branch_out <= 0; mem_read_out <= 0; mem_write_out <= 0;
branch_target_out <= 0; alu_result_out <= 0; reg_data2_out <= 0;
zero_out <= 0; rd_out <= 0;
end else begin
wb_reg_write_out <= wb_reg_write_in; wb_mem_to_reg_out <= wb_mem_to_reg_in;
mem_branch_out <= mem_branch_in; mem_read_out <= mem_read_in; mem_write_out <= mem_write_in;
branch_target_out <= branch_target_in; alu_result_out <= alu_result_in; reg_data2_out <= reg_data2_in;
zero_out <= zero_in; rd_out <= rd_in;
end
end
endmodule

module mem_wb_reg(
input clk, rst_n,
input wb_reg_write_in, wb_mem_to_reg_in,
input [31:0] mem_rdata_in, alu_result_in,
input [4:0] rd_in,
output reg wb_reg_write_out, wb_mem_to_reg_out,
output reg [31:0] mem_rdata_out, alu_result_out,
output reg [4:0] rd_out
);
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wb_reg_write_out <= 0; wb_mem_to_reg_out <= 0;
mem_rdata_out <= 0; alu_result_out <= 0; rd_out <= 0;
end else begin
wb_reg_write_out <= wb_reg_write_in; wb_mem_to_reg_out <= wb_mem_to_reg_in;
mem_rdata_out <= mem_rdata_in; alu_result_out <= alu_result_in; rd_out <= rd_in;
end
end
endmodule