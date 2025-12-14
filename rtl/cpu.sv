`timescale 1ns / 1ps

module cpu(
    input logic clk, reset,
    output logic [31:0] write_data, data_addr,
    output logic mem_write_mem
    );
    
    logic [31:0] pc_if, instr, read_data_mem, write_data_mem;
    
    core cu(.clk(clk), .reset(reset), .instr(instr), .read_data_mem(read_data_mem), .pc_if(pc_if), .mem_write_mem(mem_write_mem), 
    .alu_result_mem(data_addr), .write_data_mem(write_data));
    
    instruction_memory imem(.addr(pc_if), .read_data(instr));
    
    data_memory dmem(.clk(clk), .write_en(mem_write_mem), .addr(data_addr), .write_data(write_data), .read_data(read_data_mem)); 
    
endmodule
