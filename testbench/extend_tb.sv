`timescale 1ns / 1ps

module extend_tb;

    logic [31:0] instr; 
    logic [1:0] imm_src;
    logic [31:0] imm_ext;
    
    extend dut(
        .instr(instr), 
        .imm_src(imm_src), 
        .imm_ext(imm_ext));
    
    initial begin
        imm_src = 2'b00;
        instr = 32'h98d00000;
        #10;
        
        instr = 32'hbcd00000;
        #10;
        
        instr = 32'h73b00000;
        #10;
        
        imm_src = 2'b01;
        instr = 32'b11111110000000000000111110000000; //display 32'b1;
        #10;
        
        instr = 32'b01111110000000000000111110000000; // show sign extension works
        #10;
        
        imm_src = 2'b10;
        instr = 32'b11111110000000000000111110000000; //display 32'b1;
        #10;
        
        instr = 32'b01111110000000000000111110000000; // show sign extension works
        #10;
        
        imm_src = 2'b11;
        instr = 32'b11111111111111111111000000000000;
        #10;
        
        instr = 32'b01111111111111111111000000000000;
        #10;
        
        $finish;
        end
        
        
        
        
        
    
endmodule