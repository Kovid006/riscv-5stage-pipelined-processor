`timescale 1ns / 1ps

module imm_gen (
input [31:0] instr,
output reg [31:0] imm_ext
);
always @(*) begin
case (instr[6:0])
7'b0010011,
7'b0000011,
7'b1100111:
imm_ext = {{20{instr[31]}}, instr[31:20]};
7'b0100011:
imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
7'b1100011:
imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
default:
imm_ext = 0;
endcase
end
endmodule