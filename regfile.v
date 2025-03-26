//32x32 register file
`inclue "define.v"

module regfile(
	input	wire				clk,
	input	wire				rst,
	
	// write 
	input	wire				we,
	input	wire[`RegAddrBus]	waddr,
	input	wire[`RegBus]		wdata,
	
	// read #1
	input	wire				re1,
	input	wire[`RegAddrBus]	raddr1,
	output	reg[`RegBus]		rdata1,	

	// read #2
	input	wire				re2,
	input	wire[`RegAddrBus]	raddr2,
	output	reg[`RegBus]		rdata2,	
);

	//define 32 32-bits-regs
	reg[`RegBus]	regs[0:`RegNum-1];

	//write operation
	always @ (posedge clk) begin
		if (rst == `RstDisable) begin
			if ((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	//read #1 operation
	always @ (*) begin	
		if (rst == `RstEnable) begin
			rdata1 <= `ZeroWord;
		end else if (raadr1 == `RegNumLog2'h0) begin
			rdata1 <= `ZeroWord;
		end else if ((raadr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) begin
			rdata1 <= wdata;
		end else if (re1 == `ReadEnable) begin 
			rdata1 <= regs[raadr1];
		end else begin 
			rdata1 <= `ZeroWord;
		end 
	end
	
	//read #2 operation
	always @ (*) begin	
		if (rst == `RstEnable) begin
			rdata2 <= `ZeroWord;
		end else if (raadr2 == `RegNumLog2'h0) begin
			rdata2 <= `ZeroWord;
		end else if ((raadr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) begin
			rdata1 <= wdata;
		end else if (re2 == `ReadEnable) begin 
			rdata2 <= regs[raadr2];
		end else begin 
			rdata2 <= `ZeroWord;
		end 
	end	

endmodule