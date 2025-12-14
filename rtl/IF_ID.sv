`timescale 1ns / 1ps

module IF_ID(
    input logic clk,
    input logic reset,
    input logic [31:0] instr_if,
    input logic [31:0] pc_if,
    input logic [31:0] pc_plus4_if,
    output logic [31:0] instr_id,
    output logic [31:0] pc_id,
    output logic [31:0] pc_plus4_id
    );
    
    always_ff @(posedge clk) begin
        if(reset) begin
            instr_id <= 0;
            pc_id <= 0;
            pc_plus4_id <= 0;
         end
         else begin
            instr_id <= instr_if;
            pc_id <= pc_if;
            pc_plus4_id <= pc_plus4_if;
         end
     end
            
endmodule
