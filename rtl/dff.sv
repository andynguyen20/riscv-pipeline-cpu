`timescale 1ns / 1ps

module dff(
    input logic clk, 
    input logic reset,
    input logic stall_if,
    input logic [31:0] d,
    output logic [31:0] q
    );
    
    always_ff @(posedge(clk), posedge(reset)) begin
        if(reset)
            q <= 0;
        else if(~stall_if) 
            q <= d;
    end     
    
endmodule