`timescale 1ns / 1ps

module GateDelayGen(
    input i_clk,
    input i_rst,
    input i_trigger,
    input [31:0] delay,
    input [31:0] width,
    output o_PULSE,
    output o_busy
    );

initial	sync_pipe      = 1'b0;
initial	r_trigger_state = 1'b0;

//run input through two flip-flops to avoid metastability    
always @(posedge clk) { r_trigger_state, sync_pipe } <= { sync_pipe, i_trigger };

//generate trigger event (synchronized to clock)
initial	r_last         = 1'b0;
initial	r_button_event = 1'b0;
always @(posedge clk)
begin
    r_last <= r_trigger_state;
    r_trigger_event <= (r_trigger_state)&&(!r_last);
end
    
initial counter = 33'b0;
initial r_stb = 1'b0;

//create counter strobe signal
always @(posedge i_clk)
	r_stb <= (counter == delay + width);

// run counter
always @ (posedge clk) begin : PULSE_GENERATOR
	if (i_rst) begin
		counter <= 0;
	end else if (r_stb) counter <= 0;
	else if (r_trigger_event) counter <= counter + 1;
	else if (o_busy) counter <= counter + 1;
end
  
assign o_PULSE = ((counter > delay) && (counter < (delay + width))) ? 1 : 0;
assign o_busy = (counter > 0) ? 1 : 0;

	
endmodule
