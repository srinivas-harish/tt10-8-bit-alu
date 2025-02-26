/*
 * Copyright (c) 2025 [Your Name] - Handcrafted for Digital Logic Design HW
 * SPDX-License-Identifier: Apache-2.0
 * Note: This is my personal twist on bit manipulation—think of it like spinning a binary wheel!
 */

`default_nettype none

module tt_um_l2 (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);
 
    wire [7:0] A = ui_in;        // Input A to rotate
    wire [7:0] B = uio_in;       // Input B, use B[2:0] as rotation selector
    wire [2:0] rotate_amount = B[2:0];  // 3-bit selector for rotation (0-7)

    //  for the rotated result
    reg [7:0] C;

    // for left circular rotation
    always @(*) begin
        case (rotate_amount)
            3'b000: C = A;                    
            3'b001: C = {A[6:0], A[7]};       
            3'b010: C = {A[5:0], A[7:6]};     
            3'b011: C = {A[4:0], A[7:5]};     
            3'b100: C = {A[3:0], A[7:4]};     
            3'b101: C = {A[2:0], A[7:3]};     
            3'b110: C = {A[1:0], A[7:2]};     
            3'b111: C = {A[0], A[7:1]};       
            default: C = A;                   // Default (should never occur)
        endcase
    end
 
    assign uo_out = C;         
    assign uio_out = 8'b0;     
    assign uio_oe = 8'b0;      
 
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
