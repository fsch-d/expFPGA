`timescale 1ns / 1ps

module PulseGen(
    input clk,
    input [31:0] period,
    input [31:0] width,
    output PULSE
    );
    
reg [31:0] counter=0;

always@(posedge clk) begin
    if (counter<period) counter<=counter+1;     
    else counter<=0;
end    
 
assign PULSE=(counter<width) ? 1:0;
    
endmodule
