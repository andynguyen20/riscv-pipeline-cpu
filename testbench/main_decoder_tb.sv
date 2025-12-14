`timescale 1ns / 1ps

module main_decoder_tb;

    logic [6:0] op;
    logic [1:0] result_src;
    logic mem_write;
    logic branch;
    logic alu_src;
    logic reg_write;
    logic jump;
    logic [1:0] imm_src;
    logic [1:0] alu_op;
    
    main_decoder dut(
        .op(op), 
        .result_src(result_src), 
        .mem_write(mem_write), 
        .branch(branch), 
        .alu_src(alu_src), 
        .reg_write(reg_write), 
        .jump(jump), 
        .imm_src(imm_src), 
        .alu_op(alu_op));
        
    initial begin
        op = 7'b0000011;
        #10;
        
        op = 7'b0100011;
        #10;
        
        op = 7'b0110011;
        #10;
        
        op = 7'b1100011;
        #10;
        
        op = 7'b0010011;
        #10;
        
        op = 7'b1101111;
        #10;
        
        op = 7'bxxxxxxx;
        #10;
        $finish;
     end    

endmodule