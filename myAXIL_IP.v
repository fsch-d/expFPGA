`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// This module has the following dependencies (Download at GitHub, from Gisselquist Technology, LLC, Apache 2 license)
// easyaxil.v   // https://github.com/ZipCPU/wb2axip/blob/master/rtl/easyaxil.v
// skidbuffer.v // https://github.com/ZipCPU/wb2axip/blob/master/rtl/skidbuffer.v
//////////////////////////////////////////////////////////////////////////////////
// The module easyaxil (in easyaxil.v) requires modifications:
// 
// 1. change C_AXI_DATA_WIDTH in the parameter declaration from localparam to parameter:
//		parameter	C_AXI_DATA_WIDTH = 32,
//
// 2. Add the following output ports to the module:
//		output	wire	[C_AXI_DATA_WIDTH-1:0]				slv_reg0,
//		output	wire	[C_AXI_DATA_WIDTH-1:0]				slv_reg1,
//		output	wire	[C_AXI_DATA_WIDTH-1:0]				slv_reg2,
//		output	wire	[C_AXI_DATA_WIDTH-1:0]				slv_reg3
//
// 3. Assign values to the new outputs (This can be done in the section "Register/wire signal declarations"):
//	assign slv_reg0 = r0;
//	assign slv_reg1 = r1;
//	assign slv_reg2 = r2;
//	assign slv_reg3 = r3;
//////////////////////////////////////////////////////////////////////////////////



//Change module name if you want to
module myAXIL_IP #(
		// {{{
		//
		// Size of the AXI-lite bus.  These are fixed, since 1) AXI-lite
		// is fixed at a width of 32-bits by Xilinx def'n, and 2) since
		// we only ever have 4 configuration words.
		parameter	C_AXI_ADDR_WIDTH = 4,
		parameter	C_AXI_DATA_WIDTH = 32,
		parameter [0:0]	OPT_SKIDBUFFER = 1'b0,
		parameter [0:0]	OPT_LOWPOWER = 0
		// }}}
	) (
		// {{{
		input	wire					S_AXI_ACLK,
		input	wire					S_AXI_ARESETN,
		//
		input	wire					S_AXI_AWVALID,
		output	wire					S_AXI_AWREADY,
		input	wire	[C_AXI_ADDR_WIDTH-1:0]		S_AXI_AWADDR,
		input	wire	[2:0]				S_AXI_AWPROT,
		//
		input	wire					S_AXI_WVALID,
		output	wire					S_AXI_WREADY,
		input	wire	[C_AXI_DATA_WIDTH-1:0]		S_AXI_WDATA,
		input	wire	[C_AXI_DATA_WIDTH/8-1:0]	S_AXI_WSTRB,
		//
		output	wire					S_AXI_BVALID,
		input	wire					S_AXI_BREADY,
		output	wire	[1:0]				S_AXI_BRESP,
		//
		input	wire					S_AXI_ARVALID,
		output	wire					S_AXI_ARREADY,
		input	wire	[C_AXI_ADDR_WIDTH-1:0]		S_AXI_ARADDR,
		input	wire	[2:0]				S_AXI_ARPROT,
		//
		output	wire					S_AXI_RVALID,
		input	wire					S_AXI_RREADY,
		output	wire	[C_AXI_DATA_WIDTH-1:0]		S_AXI_RDATA,
		output	wire	[1:0]				S_AXI_RRESP
		// }}}
		
		// Add custom ports here
		
    );


// These are the AXI Lite registers (4 times 32-bit). The names can be changed to something more meaningful.
wire [C_AXI_DATA_WIDTH-1:0] my_r0;
wire [C_AXI_DATA_WIDTH-1:0] my_r1;
wire [C_AXI_DATA_WIDTH-1:0] my_r2;
wire [C_AXI_DATA_WIDTH-1:0] my_r3;
    
    
    easyaxil #(
    .C_AXI_ADDR_WIDTH( C_AXI_ADDR_WIDTH ),
    .C_AXI_DATA_WIDTH( C_AXI_DATA_WIDTH ),
    .OPT_SKIDBUFFER(OPT_SKIDBUFFER),
    .OPT_LOWPOWER(OPT_LOWPOWER))
control_easyaxil_U(
    .S_AXI_ACLK(S_AXI_ACLK),
    .S_AXI_ARESETN(S_AXI_ARESETN),
    .S_AXI_AWVALID(S_AXI_AWVALID),
    .S_AXI_AWREADY(S_AXI_AWREADY),
    .S_AXI_AWADDR(S_AXI_AWADDR),
    .S_AXI_AWPROT(S_AXI_AWPROT),
    .S_AXI_WVALID(S_AXI_WVALID),
    .S_AXI_WREADY(S_AXI_WREADY),
    .S_AXI_WDATA(S_AXI_WDATA),
    .S_AXI_WSTRB(S_AXI_WSTRB),
    .S_AXI_BVALID(S_AXI_BVALID),
    .S_AXI_BREADY(S_AXI_BREADY),
    .S_AXI_BRESP(S_AXI_BRESP),
    .S_AXI_ARVALID(S_AXI_ARVALID),
    .S_AXI_ARREADY(S_AXI_ARREADY),
    .S_AXI_ARADDR(S_AXI_ARADDR),
    .S_AXI_ARPROT(S_AXI_ARPROT),
    .S_AXI_RVALID(S_AXI_RVALID),
    .S_AXI_RREADY(S_AXI_RREADY),
    .S_AXI_RDATA(S_AXI_RDATA),
    .S_AXI_RRESP(S_AXI_RRESP),
    // The following are again the AXI Lite registers. The names my_r* have to match the declaration above. 
    .slv_reg0(my_r0),
    .slv_reg1(my_r1),
    .slv_reg2(my_r2),
    .slv_reg3(my_r3)
);


/// include custom code here

endmodule
