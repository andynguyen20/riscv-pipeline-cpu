`timescale 1ns / 1ps

module dff_tb;

    logic clk;
    logic reset;
    logic [31:0] d;
    logic [31:0] q;
    
    dff dut(
        .clk(clk), 
        .reset(reset), 
        .d(d), 
        .q(q));
    
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    initial begin
        d = 32'h9e3b;
        #10;
        
        d = 32'hdcc8;
        #10;
        
        #10;
        
        reset = 1'b1;
        #10;
        
        reset = 1'b0;
        d = 32'h34d3;
        #10;
        
        d = 32'h1b3c;
        #10;
        $finish;
    end


endmodule