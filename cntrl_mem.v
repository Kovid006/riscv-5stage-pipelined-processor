`timescale 1ns / 1ps

module control_unit (
input [6:0] opcode,
output reg branch,
output reg mem_read,
output reg mem_to_reg,
output reg [1:0] alu_op,
output reg mem_write,
output reg alu_src,
output reg reg_write
);

always @(*) begin
{branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op} = 0;
case (opcode)
7'b0110011: begin // R-Type (e.g., add, sub, or)
reg_write = 1;
alu_op = 2'b10;
end
7'b0010011: begin // I-Type (e.g., addi)
alu_src = 1;
reg_write = 1;
alu_op = 2'b10;
end
7'b0000011: begin // Load (e.g., lw)
alu_src  = 1;
mem_read = 1;
mem_to_reg = 1;
reg_write = 1;
alu_op = 2'b00;
end
7'b0100011: begin // Store (e.g., sw)
alu_src = 1;
mem_write = 1;
alu_op = 2'b00;
end
7'b1100011: begin // Branch (e.g., beq)
branch = 1;
alu_op = 2'b01;
end
endcase
end
endmodule