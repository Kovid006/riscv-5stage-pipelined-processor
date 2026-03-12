`timescale 1ns / 1ps

module rv32i_top (
input clk,
input rst_n,// If the branch (beq) worked correctly, x8 will be 0 (skipped) and x9 will be 1

output [31:0] final_wb_data
);

// IF Stage
wire [31:0] pc_IF, next_pc, pc_plus_4_IF, instr_IF;

// ID Stage
wire [31:0] pc_ID, instr_ID, reg_rdata1_ID, reg_rdata2_ID, imm_ext_ID;
wire branch_ID, mem_read_ID, mem_to_reg_ID, mem_write_ID, alu_src_ID, reg_write_ID;
wire [1:0] alu_op_ID;

// EX Stage
wire [31:0] pc_EX, reg_rdata1_EX, reg_rdata2_EX, imm_ext_EX;
wire [4:0] rd_EX;
wire [2:0] funct3_EX;
wire funct7_EX;
wire wb_reg_write_EX, wb_mem_to_reg_EX;
wire mem_branch_EX, mem_read_EX, mem_write_EX;
wire [1:0] ex_alu_op_EX;
wire ex_alu_src_EX;
wire [3:0] alu_ctrl_EX;
wire [31:0] src_b_EX, alu_result_EX, branch_target_EX;
wire zero_EX;

// MEM Stage
wire wb_reg_write_MEM, wb_mem_to_reg_MEM;
wire mem_branch_MEM, mem_read_MEM, mem_write_MEM;
wire [31:0] branch_target_MEM, alu_result_MEM, reg_rdata2_MEM, mem_rdata_MEM;
wire zero_MEM;
wire [4:0] rd_MEM;
wire pc_src_MEM;

// WB Stage
wire wb_reg_write_WB, wb_mem_to_reg_WB;
wire [31:0] mem_rdata_WB, alu_result_WB, wb_data_WB;
wire [4:0] rd_WB;

assign pc_plus_4_IF = pc_IF + 4;
assign next_pc = pc_src_MEM ? branch_target_MEM : pc_plus_4_IF;
fetch_unit fetch (
.clk(clk),
.rst_n(rst_n),
.next_pc(next_pc),
.pc(pc_IF)
);
instruction_memory imem (
.pc(pc_IF), 
.instruction(instr_IF));
if_id_reg IF_ID (
.clk(clk),
.rst_n(rst_n),
.pc_in(pc_IF),
.instr_in(instr_IF),
.pc_out(pc_ID),
.instr_out(instr_ID)
);

control_unit ctrl (
.opcode(instr_ID[6:0]),
.branch(branch_ID),
.mem_read(mem_read_ID),
.mem_to_reg(mem_to_reg_ID),
.alu_op(alu_op_ID),
.mem_write(mem_write_ID),
.alu_src(alu_src_ID),
.reg_write(reg_write_ID)
);
register_file rf (
.clk(clk), 
.reg_write(wb_reg_write_WB),
.rs1(instr_ID[19:15]),
.rs2(instr_ID[24:20]),
.rd(rd_WB),
.write_data(wb_data_WB),
.read_data1(reg_rdata1_ID),
.read_data2(reg_rdata2_ID)
);
imm_gen imm (
.instr(instr_ID),
.imm_ext(imm_ext_ID)
);
id_ex_reg ID_EX (
.clk(clk), .rst_n(rst_n),
.wb_reg_write_in(reg_write_ID),
.wb_mem_to_reg_in(mem_to_reg_ID),
.mem_branch_in(branch_ID),
.mem_read_in(mem_read_ID),
.mem_write_in(mem_write_ID),
.ex_alu_op_in(alu_op_ID),
.ex_alu_src_in(alu_src_ID),
.pc_in(pc_ID),
.reg_data1_in(reg_rdata1_ID),
.reg_data2_in(reg_rdata2_ID),
.imm_in(imm_ext_ID),
.rd_in(instr_ID[11:7]),
.funct3_in(instr_ID[14:12]),
.funct7_in(instr_ID[30]),
.wb_reg_write_out(wb_reg_write_EX),
.wb_mem_to_reg_out(wb_mem_to_reg_EX),
.mem_branch_out(mem_branch_EX),
.mem_read_out(mem_read_EX),
.mem_write_out(mem_write_EX),
.ex_alu_op_out(ex_alu_op_EX),
.ex_alu_src_out(ex_alu_src_EX),
.pc_out(pc_EX),
.reg_data1_out(reg_rdata1_EX),
.reg_data2_out(reg_rdata2_EX),
.imm_out(imm_ext_EX),
.rd_out(rd_EX),
.funct3_out(funct3_EX),
.funct7_out(funct7_EX)
);

assign branch_target_EX = pc_EX + imm_ext_EX;
assign src_b_EX = ex_alu_src_EX ? imm_ext_EX : reg_rdata2_EX;
alu_control alu_c (
.alu_op(ex_alu_op_EX),
.funct3(funct3_EX),
.funct7(funct7_EX),
.alu_ctrl(alu_ctrl_EX)
);
alu main_alu (
.src_a(reg_rdata1_EX),
.src_b(src_b_EX),
.alu_ctrl(alu_ctrl_EX),
.result(alu_result_EX),
.zero(zero_EX)
);
ex_mem_reg EX_MEM (
.clk(clk),
.rst_n(rst_n),
.wb_reg_write_in(wb_reg_write_EX),
.wb_mem_to_reg_in(wb_mem_to_reg_EX),
.mem_branch_in(mem_branch_EX),
.mem_read_in(mem_read_EX),
.mem_write_in(mem_write_EX),
.branch_target_in(branch_target_EX),
.alu_result_in(alu_result_EX),
.reg_data2_in(reg_rdata2_EX),
.zero_in(zero_EX),
.rd_in(rd_EX),
.wb_reg_write_out(wb_reg_write_MEM),
.wb_mem_to_reg_out(wb_mem_to_reg_MEM),
.mem_branch_out(mem_branch_MEM),
.mem_read_out(mem_read_MEM),
.mem_write_out(mem_write_MEM),
.branch_target_out(branch_target_MEM),
.alu_result_out(alu_result_MEM),
.reg_data2_out(reg_rdata2_MEM),
.zero_out(zero_MEM),
.rd_out(rd_MEM)
);

assign pc_src_MEM = mem_branch_MEM & zero_MEM;
data_memory dmem (
.clk(clk),
.mem_write(mem_write_MEM),
.mem_read(mem_read_MEM),
.addr(alu_result_MEM),
.write_data(reg_rdata2_MEM),
.read_data(mem_rdata_MEM)
);
mem_wb_reg MEM_WB (
.clk(clk),
.rst_n(rst_n),
.wb_reg_write_in(wb_reg_write_MEM),
.wb_mem_to_reg_in(wb_mem_to_reg_MEM),
.mem_rdata_in(mem_rdata_MEM),
.alu_result_in(alu_result_MEM),
.rd_in(rd_MEM),
.wb_reg_write_out(wb_reg_write_WB),
.wb_mem_to_reg_out(wb_mem_to_reg_WB),
.mem_rdata_out(mem_rdata_WB),
.alu_result_out(alu_result_WB),
.rd_out(rd_WB)
);

assign wb_data_WB = wb_mem_to_reg_WB ? mem_rdata_WB : alu_result_WB;
assign final_wb_data = wb_data_WB;

endmodule
