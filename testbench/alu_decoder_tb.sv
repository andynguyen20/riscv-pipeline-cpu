`timescale 1ns / 1ps

module alu_decoder_tb;

    logic opb5; 
    logic [2:0] funct3;
    logic funct7b5;
    logic [1:0] alu_op;
    logic [2:0] alu_control;
    
    alu_decoder dut(
        .opb5(opb5),
        .funct3(funct3), 
        .funct7b5(funct7b5), 
        .alu_op(alu_op), 
        .alu_control(alu_control));

    initial begin
        alu_op = 2'b00;
        #10;
        
        alu_op = 2'b01;
        #10;
        
        alu_op = 2'b10;
        funct3 = 3'b000;
        funct7b5 = 1'b1;
        opb5 = 1'b1;
        #10;
        
        
        funct7b5 = 1'b0;
        opb5 = 1'b0;
        #10;
        
        funct3 = 3'b010;
        #10;
        
        funct3 = 3'b110;
        #10;
        
        funct3 = 3'b111;
        #10;
        
        funct3 = 3'bxxx;
        #10;
        $finish;
     end
        

endmodule
