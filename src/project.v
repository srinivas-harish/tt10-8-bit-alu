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

   
  wire [15:0] input_vector;
  assign input_vector = {ui_in, uio_in};

  
  reg [7:0] priority_out;

   
  always @(*) begin
    if (input_vector == 16'b0000_0000_0000_0000) begin
      priority_out = 8'b1111_0000;   
    end else begin
      priority_out = 8'b0000_0000;   
      casez (input_vector)
        16'b1???_????_????_????: priority_out = 8'd15;
        16'b01??_????_????_????: priority_out = 8'd14;
        16'b001?_????_????_????: priority_out = 8'd13;
        16'b0001_????_????_????: priority_out = 8'd12;
        16'b0000_1???_????_????: priority_out = 8'd11;
        16'b0000_01??_????_????: priority_out = 8'd10;
        16'b0000_001?_????_????: priority_out = 8'd9;
        16'b0000_0001_????_????: priority_out = 8'd8;
        16'b0000_0000_1???_????: priority_out = 8'd7;
        16'b0000_0000_01??_????: priority_out = 8'd6;
        16'b0000_0000_001?_????: priority_out = 8'd5;
        16'b0000_0000_0001_????: priority_out = 8'd4;
        16'b0000_0000_0000_1???: priority_out = 8'd3;
        16'b0000_0000_0000_01??: priority_out = 8'd2;
        16'b0000_0000_0000_001?: priority_out = 8'd1;
        16'b0000_0000_0000_0001: priority_out = 8'd0;
        default: priority_out = 8'b0000_0000;
      endcase
    end
  end

  
  assign uo_out = priority_out;
  assign uio_out = 8'b0;
  assign uio_oe = 8'b0;

   
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
