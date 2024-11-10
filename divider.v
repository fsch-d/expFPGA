`timescale 1ns / 1ps

module Divider(
    input i_clk,
    input i_rst,
    input i_trigger,
    input [31:0] div,
    output o_PULSE
);
    
reg sync_pipe;
reg r_trigger_state;
reg r_last;
reg r_trigger_event;
reg [31:0] counter;
reg r_stb;

initial sync_pipe      = 1'b0;
initial	r_trigger_state = 1'b0;

//run input through two flip-flops to avoid metastability    
always @(posedge i_clk) { r_trigger_state, sync_pipe } <= { sync_pipe, i_trigger };


//generate trigger event (synchronized to clock)
initial	r_last         = 1'b0;
initial	r_trigger_event = 1'b0;
always @(posedge i_clk)
begin
    r_last <= r_trigger_state;
    r_trigger_event <= (r_trigger_state)&&(!r_last);
end
    
initial counter = 32'b0;
initial r_stb = 1'b0;

//create counter strobe signal
always @(posedge i_clk)
	r_stb <= (counter == div);

// run counter
always @ (posedge i_clk) begin
	if (i_rst) begin
		counter <= 0;
	end else if (r_stb) counter <= 0;
	else if (r_trigger_event) counter <= counter + 1;
end
  
assign o_PULSE = (r_trigger_event && counter == 0) ? 1 : 0;

	
endmodule
