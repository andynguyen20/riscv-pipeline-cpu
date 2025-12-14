`timescale 1ns / 1ps

module EX_MEM(
    input logic clk,
    input logic reset,
    
    //datapath components
    input logic [31:0] alu_result_ex,
    input logic [31:0] write_data_ex,
    input logic [4:0] reg_dest_ex,
    input logic [31:0] pc_plus4_ex,
    
    input logic reg_write_ex,
    input logic [1:0] result_src_ex,
    input logic mem_write_ex,
    
    output logic [31:0] alu_result_mem,
    output logic [31:0] write_data_mem,
    output logic [4:0] reg_dest_mem,
    output logic [31:0] pc_plus4_mem,

    output logic reg_write_mem,
    output logic [1:0] result_src_mem,
    output logic mem_write_mem
    );
    
    always_ff @(posedge clk) begin
        if(reset) begin
        //datapath components
            alu_result_mem <= 0;
            write_data_mem <= 0;
            reg_dest_mem <= 0;
            pc_plus4_mem <= 0;
        //control unit components
            reg_write_mem <= 0;
            result_src_mem <= 0;
            mem_write_mem <= 0;
        end
        else begin
        //datapath components
            alu_result_mem <= alu_result_ex;
            write_data_mem <= write_data_ex;
            reg_dest_mem <= reg_dest_ex;
            pc_plus4_mem <= pc_plus4_ex;
        //control unit components
            reg_write_mem <= reg_write_ex;
            result_src_mem <= result_src_ex;
            mem_write_mem <= mem_write_ex;
        end
    end
    
endmodule
