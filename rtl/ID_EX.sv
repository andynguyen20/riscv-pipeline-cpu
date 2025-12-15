`timescale 1ns / 1ps

module ID_EX(
    input logic clk,
    input logic reset,
    input logic flush_ex,
    
    input logic [31:0] read_data1_id,
    input logic [31:0] read_data2_id,
    input logic [31:0] pc_id,
    input logic [4:0] source_reg1_id,
    input logic [4:0] source_reg2_id,
    input logic [4:0] reg_dest_id,
    input logic [31:0] imm_ext_id,
    input logic [31:0] pc_plus4_id,
    
    input logic reg_write_id,
    input logic [1:0] result_src_id,
    input logic mem_write_id,
    input logic jump_id,
    input logic branch_id,
    input logic [2:0] alu_control_id,
    input logic alu_src_id,
    
    output logic [31:0] read_data1_ex,
    output logic [31:0] read_data2_ex,
    output logic [31:0] pc_ex,
    output logic [4:0] source_reg1_ex,
    output logic [4:0] source_reg2_ex,
    output logic [4:0] reg_dest_ex,
    output logic [31:0] imm_ext_ex,
    output logic [31:0] pc_plus4_ex,
    
    output logic reg_write_ex,
    output logic [1:0] result_src_ex,
    output logic mem_write_ex,
    output logic jump_ex,
    output logic branch_ex,
    output logic [2:0] alu_control_ex,
    output logic alu_src_ex
    );
    
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
        //datapath components
            read_data1_ex <= 0;
            read_data2_ex <= 0;
            pc_ex <= 0;
            source_reg1_ex <= 0;
            source_reg2_ex <= 0;
            reg_dest_ex <= 0;
            imm_ext_ex <= 0;
            pc_plus4_ex <= 0;
        //control unit components
            reg_write_ex <= 0;
            result_src_ex <= 0;
            mem_write_ex <= 0;
            jump_ex <= 0;
            branch_ex <= 0;
            alu_control_ex <= 0;
            alu_src_ex <= 0;
        end
        else if (flush_ex) begin
        //datapath components
            read_data1_ex <= read_data1_id;
            read_data2_ex <= read_data2_id;
            pc_ex <= pc_id;
            source_reg1_ex <= source_reg1_id;
            source_reg2_ex <= source_reg2_id;
            reg_dest_ex <= reg_dest_id;
            imm_ext_ex <= imm_ext_id;
            pc_plus4_ex <= pc_plus4_id;
        //control unit components
            reg_write_ex <= 0;
            result_src_ex <= 0;
            mem_write_ex <= 0;
            jump_ex <= 0;
            branch_ex <= 0;
            alu_control_ex <= 0;
            alu_src_ex <= 0;
        end
        else begin
        //datapath components
            read_data1_ex <= read_data1_id;
            read_data2_ex <= read_data2_id;
            pc_ex <= pc_id;
            source_reg1_ex <= source_reg1_id;
            source_reg2_ex <= source_reg2_id;
            reg_dest_ex <= reg_dest_id;
            imm_ext_ex <= imm_ext_id;
            pc_plus4_ex <= pc_plus4_id;
        //control unit components
            reg_write_ex <= reg_write_id;
            result_src_ex <= result_src_id;
            mem_write_ex <= mem_write_id;
            jump_ex <= jump_id;
            branch_ex <= branch_id;
            alu_control_ex <= alu_control_id;
            alu_src_ex <= alu_src_id;
        end
     end
         
endmodule
