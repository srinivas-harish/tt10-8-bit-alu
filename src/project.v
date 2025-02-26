 

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

  wire [2:0] rotate_by = uio_in[2:0];
  
  wire [7:0] input_a = ui_in;  
  reg [7:0] rotated_output;

  always @(*) begin
    case (rotate_by)
      3'b000: rotated_output = input_a;                     
      3'b001: rotated_output = {input_a[6:0], input_a[7]};  
      3'b010: rotated_output = {input_a[5:0], input_a[7:6]}; 
      3'b011: rotated_output = {input_a[4:0], input_a[7:5]}; 
      3'b100: rotated_output = {input_a[3:0], input_a[7:4]}; 
      3'b101: rotated_output = {input_a[2:0], input_a[7:3]}; 
      3'b110: rotated_output = {input_a[1:0], input_a[7:2]}; 
      3'b111: rotated_output = {input_a[0], input_a[7:1]};   
      default: rotated_output = input_a;                    // Default (shouldn't happen)
    endcase
  end

  assign uo_out = rotated_output;
  assign uio_out = 8'b0;  
  assign uio_oe = 8'b0;    

  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
