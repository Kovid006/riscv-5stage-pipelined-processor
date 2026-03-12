`timescale 1ns / 1ps

module instruction_memory (
input wire [31:0] pc,
output reg [31:0] instruction
);
always @(*) begin
case (pc)
32'd0:  instruction = 32'h00F00093; // addi x1, x0, 15
32'd4:  instruction = 32'h00500113; // addi x2, x0, 5

32'd8:  instruction = 32'h00000013; // NOP 1
32'd12: instruction = 32'h00000013; // NOP 2
32'd16: instruction = 32'h00000013; // NOP 3

32'd20: instruction = 32'h402081B3; // sub x3, x1, x2  (x3 = 10)
32'd24: instruction = 32'h0020E233; // or x4, x1, x2
32'd28: instruction = 32'h0020F2B3; // and x5, x1, x2
32'd32: instruction = 32'h00112333; // slt x6, x2, x1

32'd36: instruction = 32'h00302423; // sw x3, 8(x0)
32'd40: instruction = 32'h00802383; // lw x7, 8(x0)

32'd44: instruction = 32'h00000013; // NOP 1
32'd48: instruction = 32'h00000013; // NOP 2
32'd52: instruction = 32'h00000013; // NOP 3

32'd56: instruction = 32'h00718A63; 

32'd60: instruction = 32'h00000013; // NOP 1
32'd64: instruction = 32'h00000013; // NOP 2
32'd68: instruction = 32'h00000013; // NOP 3

32'd72: instruction = 32'h06300413; // addi x8, x0, 99 (SKIPPED)

32'd76: instruction = 32'h00100493; // addi x9, x0, 1 (TARGET REACHED)
default: instruction = 32'h00000013;
endcase
end
endmodule