`timescale 1ns / 1ps

module alu (
input [31:0] src_a,
input [31:0] src_b,
input [3:0] alu_ctrl,
output reg [31:0] result,
output zero
);
assign zero = (result == 0);
always @(*) begin
case (alu_ctrl)
4'b0000: result = src_a & src_b;
4'b0001: result = src_a | src_b;
4'b0010: result = src_a + src_b;
4'b0110: result = src_a - src_b;
4'b0111: result = ($signed(src_a) < $signed(src_b)) ? 1 : 0;
default: result = 0;
endcase
end
endmodule