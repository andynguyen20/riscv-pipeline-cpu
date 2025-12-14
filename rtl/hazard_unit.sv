`timescale 1ns / 1ps

module hazard_unit(
    input logic [4:0] source_reg1_ex,
    input logic [4:0] source_reg2_ex,
    input logic [4:0] reg_dest_mem,
    input logic [4:0] reg_dest_wb,
    input logic reg_write_mem,
    input logic reg_write_wb,
    output logic [1:0] forward_ae,
    output logic [1:0] forward_be
    );
    
    always_comb begin
        if(((source_reg1_ex == reg_dest_mem) && reg_write_mem) && (source_reg1_ex != 0)) begin
            forward_ae = 2'b10;
        end
        else if(((source_reg1_ex == reg_dest_wb) && reg_write_wb) && (source_reg1_ex != 0)) begin
            forward_ae = 2'b01;
        end
        else begin
            forward_ae = 2'b00;
        end
        if(((source_reg2_ex == reg_dest_mem) && reg_write_mem) && (source_reg2_ex != 0)) begin
            forward_be = 2'b10;
        end
        else if(((source_reg2_ex == reg_dest_wb) && reg_write_wb) && (source_reg2_ex != 0)) begin
            forward_be = 2'b01;
        end
        else begin
            forward_be = 2'b00;
        end
     end   
    
    
endmodule
