`timescale 1ns / 1ps

module mux2_tb;

    logic [31:0] d0; 
    logic [31:0] d1;
    logic sel;
    logic [31:0] y;
    
    mux2 dut(
        .d0(d0), 
        .d1(d1), 
        .sel(sel), 
        .y(y));
    
    initial begin
        d0 = 32'h419c03fc;
        d1 = 32'h6b58400b;
        sel = 1'b0;
        #10;
        
        sel = 1'b1;
        #10;
        
        d0 = 32'h74d7edc6;
        d1 = 32'hb6f0d434;
        #10;
        
        sel = 1'b0;
        #10;
        
        d0 = 32'hdc2242bd;
        d1 = 32'hba5fb2db;
        #10;
        
        sel = 1'b1;
        #10;
        $finish;
    end
    
endmodule