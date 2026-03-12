`timescale 1ns / 1ps

module alu_control (
input [1:0] alu_op,
input [2:0] funct3,
input funct7,
output reg [3:0] alu_ctrl
);
always @(*) begin
case (alu_op)
2'b00: alu_ctrl = 4'b0010;
2'b01: alu_ctrl = 4'b0110;
2'b10: begin
case (funct3)
3'b000: alu_ctrl = funct7 ? 4'b0110 : 4'b0010;
3'b110: alu_ctrl = 4'b0001;
3'b111: alu_ctrl = 4'b0000;
3'b010: alu_ctrl = 4'b0111;
default: alu_ctrl = 4'b0000;
endcase
end
default: alu_ctrl = 4'b0000;
endcase
end
endmodule