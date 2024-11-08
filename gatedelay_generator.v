`timescale 1ns / 1ps

module GateDelayGen(
    input clk,
    input i_trigger,
    input [31:0] delay,
    input [31:0] width,
    output PULSE,
    output busy
    );

initial	sync_pipe      = 1'b0;
initial	r_trigger_state = 1'b0;

//run input through two flip-flops to avoid metastability    
always @(posedge clk) { r_trigger_state, sync_pipe } <= { sync_pipe, i_trigger };

//generate trigger event
initial	r_last         = 1'b0;
initial	r_button_event = 1'b0;
always @(posedge clk)
begin
	r_last <= r_trigger_state;
    r_trigger_event <= (r_trigger_state)&&(!r_last);
end
    
reg [31:0] counter;
reg enable;
reg trigger_old;

assign PULSE = ((counter > delay) && (counter < (delay + width))) ? 1 : 0;
assign busy = (enable == 1'b1) ? 1 : 0;

initial begin
    counter <= 0;
    enable <= 0;
    trigger_old <= 0;
end

always @ (posedge clk) begin : PULSE_GENERATOR
  if (trigger && !trigger_old) begin
      enable <= 1;
      trigger_old <= trigger;
  end else trigger_old <= trigger;
  if (counter > (delay + width)) begin 
      counter <= 0;
      enable <= 1'b0;
  end else if (enable) begin
      counter <= counter + 1;
  end else begin
      counter <= 0;
  end
end
  
    
endmodule
