`timescale 1ns / 1ps

module MEM_WB(
    input logic clk,
    input logic reset,
    
    input logic [31:0] alu_result_mem,
    input logic [31:0] read_data_mem,
    input logic [4:0] reg_dest_mem,
    input logic [31:0] pc_plus4_mem,
    
    input logic reg_write_mem,
    input logic [1:0] result_src_mem,
    
    output logic [31:0] alu_result_wb,
    output logic [31:0] read_data_wb,
    output logic [4:0] reg_dest_wb,
    output logic [31:0] pc_plus4_wb,
    
    output logic reg_write_wb,
    output logic [1:0] result_src_wb 
    );
    
    always_ff @(posedge clk) begin
        if(reset) begin
        //datapath components
            alu_result_wb <= 0;
            read_data_wb <= 0;
            reg_dest_wb <= 0;
            pc_plus4_wb <= 0;
        //control unit components
            reg_write_wb <= 0;
            result_src_wb <= 0;
        end
        else begin
        //datapath components
            alu_result_wb <= alu_result_mem;
            read_data_wb <= read_data_mem;
            reg_dest_wb <= reg_dest_mem;
            pc_plus4_wb <= pc_plus4_mem;
        //control unit components
            reg_write_wb <= reg_write_mem;
            result_src_wb <= result_src_mem;
        end
    end  
       
endmodule