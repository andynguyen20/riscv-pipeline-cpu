`timescale 1ns / 1ps

module mux3_tb;

    logic [31:0] d0;
    logic [31:0] d1;
    logic [31:0] d2;
    logic [1:0] sel;
    logic [31:0] y;
    
    mux3 dut(
        .d0(d0), 
        .d1(d1), 
        .d2(d2), 
        .sel(sel), 
        .y(y));
        
    initial begin
        d0 = 32'h37b83cf9;
        d1 = 32'hf3dc719f;
        d2 = 32'he75b262d;
        
        sel = 2'b00;
        #10;
        
        sel = 2'b01;
        #10;
        
        sel = 2'b10;
        #10;
        
        sel = 2'b11;
        #10;
        
        d0 = 32'h6420271d;
        d1 = 32'h030ceb69;
        d2 = 32'hf707ce7e;
        
        sel = 2'b00;
        #10; 
        
        sel = 2'b01;
        #10;
        
        sel = 2'b10;
        #10;
        
        sel = 2'b11;
        #10;
        
        d0 = 32'h5cc0bf9c;
        d1 = 32'hc6da743d;
        d2 = 32'h75c816b7;
        
        sel = 2'b00;
        #10; 
        
        sel = 2'b01;
        #10;
        
        sel = 2'b10;
        #10;
        
        sel = 2'b11;
        #10;
        $finish;
    end
    
endmodule
