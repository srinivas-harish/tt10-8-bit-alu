/*
 * Copyright (c) 2025 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_l3 (
    input  wire [7:0] ui_in,     
    output wire [7:0] uo_out,    
    input  wire [7:0] uio_in,    
    output wire [7:0] uio_out,   
    output wire [7:0] uio_oe,    
    input  wire       ena,       
    input  wire       clk,       
    input  wire       rst_n      
);

    // Use B[2:0] as the rotation amount  
    wire [2:0] rotate_amount = uio_in[2:0];
    wire [7:0] input_a = ui_in;  // A[7:0]

    // Output register for the rotated result
    reg [7:0] rotated_output;

    //   left rotation of A by rotate_amount positions
    always @(*) begin
        case (rotate_amount)
            3'd0:  rotated_output = input_a;                     
            3'd1:  rotated_output = {input_a[6:0], input_a[7]};  
            3'd2:  rotated_output = {input_a[5:0], input_a[7:6]};  
            3'd3:  rotated_output = {input_a[4:0], input_a[7:5]};  
            3'd4:  rotated_output = {input_a[3:0], input_a[7:4]};  
            3'd5:  rotated_output = {input_a[2:0], input_a[7:3]};  
            3'd6:  rotated_output = {input_a[1:0], input_a[7:2]};  
            3'd7:  rotated_output = {input_a[0], input_a[7:1]};    
            default: rotated_output = input_a;                    // Default (shouldn't occur)
        endcase
    end
 
    assign uo_out = rotated_output;
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;
 
    wire _unused = &{ena, clk, rst_n, uio_in[7:3], 1'b0};

endmodule
