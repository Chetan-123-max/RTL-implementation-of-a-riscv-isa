# RTL-implementation-of-a-riscv-isa

The following work is an implementation of a RISC-V based ISA(RV32IZicsr) using Verilog HDL.

It is a 5 stage pipelined processor with the following stages(IF, ID, EX, MEM, WB).
Has support for hazard detection and stalling.
Is provided with data and control paths to identify exception and perform jumps to relevent routines and return back from it.
The current clock frequency in place is 100MHz.

The Control mechanism is implemented using a hierarchical approach i.e. first we generate something called as global control signals(scope is the entire processor) and then we generate local control signals(scope limited to a particular stage only).
There are two memory modules a data memory and a instruction memory. The former is modelled as a ROM and the latter is modelled as a RAM.

A UART is designed and integrated into the SOC to enable the viewing of the outputs on a console.

Requires risc-v compiler toolchain inorder to convert high level code to binary which will then be dumped into the instruction memory.

The core is tested using risc-v unit tests provided in the risc-v tests github repository. It will then be tested for compliance using risc-v compliance architecture and then coremark would be run on it

The SOC consisting of a core, data memory, instruction memory, bus arbiter and a uart is synthesised succefully without any errors.
