`timescale 1ns / 1ps

module core(
    input logic clk,
    input logic reset,
    input logic [31:0] instr,  
    input logic [31:0] read_data_mem, 
    output logic [31:0] pc_if, 
    output logic mem_write_mem, 
    output logic [31:0] alu_result_mem, 
    output logic [31:0] write_data_mem 
    );
    
    // Instruction Fetch Stage 
    
    logic [31:0] pc_next, pc_plus4_if, pc_ex, imm_ext_ex, pc_target_ex;
    logic pc_src_ex;
    
    dff pcreg(.clk(clk), .reset(reset), .d(pc_next), .q(pc_if));
    adder pcadd4(.a(pc_if), .b(32'd4), .y(pc_plus4_if));
    adder pcaddbranch(.a(pc_ex), .b(imm_ext_ex), .y(pc_target_ex));
    mux2 pcmux(.d0(pc_plus4_if), .d1(pc_target_ex), .sel(pc_src_ex), .y(pc_next));
    
    // Instruction Fetch / Instruction Decode pipeline register
    
    logic [31:0] instr_id, pc_id, pc_plus4_id;
    
    IF_ID pr1(.clk(clk), .reset(reset), .instr_if(instr), .pc_if(pc_if), .pc_plus4_if(pc_plus4_if), .instr_id(instr_id), .pc_id(pc_id), .pc_plus4_id(pc_plus4_id));
    
    // Instruction Decode Stage
    
    logic [31:0] result_wb, read_data1_id, read_data2_id, imm_ext_id;
    logic [4:0] reg_dest_wb;
    logic [2:0] alu_control_id;
    logic [1:0] imm_src_id, result_src_id;
    logic mem_write_id, alu_src_id, reg_write_id, jump_id, branch_id, reg_write_wb;
    
    register_file rf(.clk(clk), .write_en3(reg_write_wb), .addr1(instr_id[19:15]), .addr2(instr_id[24:20]), .addr3(reg_dest_wb), .write_data3(result_wb), 
    .read_data1(read_data1_id), .read_data2(read_data2_id));
    control_unit c(.op(instr_id[6:0]), .funct3(instr_id[14:12]), .funct7b5(instr_id[30]), .result_src(result_src_id), 
    .mem_write(mem_write_id), .branch(branch_id), .alu_src(alu_src_id), .reg_write(reg_write_id), .jump(jump_id), .imm_src(imm_src_id), .alu_control(alu_control_id));
    extend ext(.instr(instr_id), .imm_src(imm_src_id), .imm_ext(imm_ext_id));
    
    // Instruction Decode / Execute pipeline register
    
    logic [31:0] read_data1_ex, read_data2_ex, pc_plus4_ex;
    logic [4:0] reg_dest_ex;
    logic [2:0] alu_control_ex;
    logic [1:0] result_src_ex;
    logic reg_write_ex, mem_write_ex, jump_ex, branch_ex, alu_src_ex; 
    
     ID_EX pr2(.clk(clk), .reset(reset), .read_data1_id(read_data1_id), .read_data2_id(read_data2_id), .pc_id(pc_id), .reg_dest_id(instr_id[11:7]), .imm_ext_id(imm_ext_id), .pc_plus4_id(pc_plus4_id), 
     .reg_write_id(reg_write_id), .result_src_id(result_src_id), .mem_write_id(mem_write_id), .jump_id(jump_id), .branch_id(branch_id), .alu_control_id(alu_control_id), .alu_src_id(alu_src_id), 
     .read_data1_ex(read_data1_ex), .read_data2_ex(read_data2_ex), .pc_ex(pc_ex), .reg_dest_ex(reg_dest_ex), .imm_ext_ex(imm_ext_ex), .pc_plus4_ex(pc_plus4_ex), .reg_write_ex(reg_write_ex), 
     .result_src_ex(result_src_ex), .mem_write_ex(mem_write_ex), .jump_ex(jump_ex), .branch_ex(branch_ex), .alu_control_ex(alu_control_ex), .alu_src_ex(alu_src_ex));
    
    // Execute Stage
    
    logic [31:0] src_b_ex, alu_result_ex;
    logic zero_ex;
    
    mux2 srcbmux(.d0(read_data2_ex), .d1(imm_ext_ex), .sel(alu_src_ex), .y(src_b_ex));
    alu alu(.a(read_data1_ex), .b(src_b_ex), .alu_control(alu_control_ex), .alu_result(alu_result_ex), .zero(zero_ex));
    
    logic bra_and_zero;
    assign bra_and_zero = branch_ex && zero_ex;
    assign pc_src_ex = jump_ex | bra_and_zero;
    
    // Execute / Memory Access pipeline register
    
    logic [31:0] pc_plus4_mem;
    logic [4:0] reg_dest_mem;
    logic [1:0] result_src_mem;
    logic reg_write_mem;
    
    EX_MEM pr3(.clk(clk), .reset(reset), .alu_result_ex(alu_result_ex), .write_data_ex(read_data2_ex), .reg_dest_ex(reg_dest_ex), .pc_plus4_ex(pc_plus4_ex), .reg_write_ex(reg_write_ex), .result_src_ex(result_src_ex), 
    .mem_write_ex(mem_write_ex), .alu_result_mem(alu_result_mem), .write_data_mem(write_data_mem), .reg_dest_mem(reg_dest_mem), .pc_plus4_mem(pc_plus4_mem), .reg_write_mem(reg_write_mem), .result_src_mem(result_src_mem), 
    .mem_write_mem(mem_write_mem));
    
    // Memory Access
    
    //Data Memory block in top level
    
    // Memory Access / Write-Back pipeline register
    
    logic [31:0] alu_result_wb, read_data_wb, pc_plus4_wb;
    logic [1:0] result_src_wb;
    
    MEM_WB pr4(.clk(clk), .reset(reset), .alu_result_mem(alu_result_mem), .read_data_mem(read_data_mem), .reg_dest_mem(reg_dest_mem), .pc_plus4_mem(pc_plus4_mem), .reg_write_mem(reg_write_mem), .result_src_mem(result_src_mem),
    .alu_result_wb(alu_result_wb), .read_data_wb(read_data_wb), .reg_dest_wb(reg_dest_wb), .pc_plus4_wb(pc_plus4_wb), .reg_write_wb(reg_write_wb), .result_src_wb(result_src_wb));
    
    // Write Back
    
    mux3 wb(.d0(alu_result_wb), .d1(read_data_wb), .d2(pc_plus4_wb), .sel(result_src_wb), .y(result_wb));
    
endmodule
