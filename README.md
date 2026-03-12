# 5-Stage Pipelined RISC-V Processor

This project implements a **32-bit RISC-V processor** with a classic **5-stage pipeline architecture** using Verilog HDL.  
The design follows the standard RISC pipeline structure and supports a subset of the **RV32I instruction set**.

## Pipeline Architecture

The processor is divided into five stages:

1. **IF – Instruction Fetch**
   - Fetches instruction from instruction memory
   - Updates the Program Counter (PC)

2. **ID – Instruction Decode**
   - Decodes instruction
   - Reads operands from the register file
   - Generates control signals

3. **EX – Execute**
   - Performs arithmetic and logic operations using the ALU
   - Computes branch targets

4. **MEM – Memory Access**
   - Reads from or writes to data memory

5. **WB – Write Back**
   - Writes results back to the register file

## Project Structure
riscv-5stage-pipelined-processor
│
├── ALU.v
├── alu_cntrl.v
├── cntrl_mem.v
├── data_mem.v
├── fetch.v
├── imm_gen.v
├── instr_mem.v
├── pipeline_regs.v
├── reg_file.v
└── tb.v

## Key Modules

| Module | Description |
| ALU.v | Performs arithmetic and logic operations |
| alu_cntrl.v | Generates ALU control signals |
| fetch.v | Handles instruction fetching and PC update |
| instr_mem.v | Instruction memory |
| data_mem.v | Data memory module |
| reg_file.v | Register file implementation |
| pipeline_regs.v | Pipeline registers between stages |
| imm_gen.v | Immediate value generator |
| tb.v | Testbench for simulation |

## Features
- 32-bit RISC-V architecture
- 5-stage pipelined CPU
- Modular Verilog design
- Pipeline registers between stages
- Testbench for simulation

## Future Improvements
- Hazard detection unit
- Data forwarding
- Branch prediction
- Support for more RISC-V instructions
- FPGA implementation
- 
## Tools Used
- Verilog HDL
- Xilinx Vivado Simulator

## Author

Kovid Agarwal  
B.Tech Electrical Engineering (VLSI)  
IIT Mandi
