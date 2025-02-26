/*
 * Copyright (c) 2025 Your Name
 * SPDX-License-Identifier: Apache-2.0
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
 
  wire [2:0] pattern = uio_in[2:0];
  
  //  for combinational logic
  reg [7:0] woven_output;

  //  from A and B based on pattern
  always @(*) begin
    case (pattern)
      3'b000: woven_output = {A[6:0], B[0]};          
      3'b001: woven_output = {A[5:0], B[1:0]};        
      3'b010: woven_output = {A[4:0], B[2:0]};        
      3'b011: woven_output = {A[3:0], B[3:0]};        
      3'b100: woven_output = {A[2:0], B[4:0]};        
      3'b101: woven_output = {A[1:0], B[5:0]};        
      3'b110: woven_output = {A[0], B[6:0]};          
      3'b111: woven_output = B;                       
      default: woven_output = A;                      // Default to A if pattern is invalid (shouldn't happen)
    endcase
  end
 
  assign uo_out = woven_output;
  assign uio_out = 8'b0;
  assign uio_oe = 8'b0;
 
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
