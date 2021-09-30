//Modelled as a Rom  
`timescale 1ns/1ns

module Instruction_mem(clk,address,instr);

input clk;
input [11:0]address;
output reg[31:0]instr;
reg [31:0] instruction_memory [0:4095]; //Total memory size: 16KB, capable of storing 4096 instructions.

initial $readmemh("../../../UnitTest-files/text_files/rv32ui-p-add.txt",instruction_memory);

always@(negedge clk)
begin
     instr <= instruction_memory[address];
end

endmodule