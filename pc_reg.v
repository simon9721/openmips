// This is the program counter of the cpu.


`inclue "define.v"

module pc_reg(
	input	wire				clk,
	input	wire				rst,
	output	reg[`InstAddrBus]	pc,
	output	reg					ce //chip enable signal for the instruction ROM
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ce <= `ChipDisable;
		end else begin
			ce <= ChipEnable;
		end
	end
	
	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			pc <= 32'h00000000;
		end else begin
			pc <= pc + 4'h4;
		end
	end
	
endmodule