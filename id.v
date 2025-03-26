//ID (instruction decoding) stage
`inclue "define.v"

module id(
	input	wire				rst,
	input	wire[`InstAddrBus]	pc_i,
	input	wire[`instBus]		inst_i,
	
	//read data from regfile
	input	wire[`RegBus]		reg1_data_i,
	input	wire[`RegBus]		reg2_data_i,	
	
	//send info to regfile
	output	reg 				reg1_read_o,
	output	reg 				reg2_read_o,
	output	reg[`RegAddrBus] 	reg1_addr_o,
	output	reg[`RegAddrBus] 	reg2_addr_o,

	//signal to ID/EX buffer
	output reg[`AluOpBus]		aluop_o,
	output reg[`AluSelBus]		alusel_o,
	output reg[`RegBus]			reg1_o,
	output reg[`RegBus]			reg2_o,
	output reg[`RegAddrBus]		wd_o,
	output reg					wreg_o,
);

//segments of the instruction
wire[5:0]	op = inst_i[31:26];
wire[4:0]	op2 = inst_i[10:6];
wire[5:0]	op3 = inst_i[5:0];
wire[4:0]	op4 = inst_i[20:16];

//save immediate value in the instruction
reg[`RegBus]	imm;

// indicator for valid instruction or not
reg				instvalid;

//Part1: instruction decoding
always @ (*) begin
	if (rst == `RstEnable) begin
		aluop_o	<=	`EXE_NOP_OP;
		alusel_o <= `EXE_RES_NOP;
		wd_o <= `NOPRegAddr;
		wreg_o <= `WriteDisable;
		instvalid <= `InstValid;
		regl_read_o <= 1'b0;
		reg2_read_o <= 1'b0;
		regl_addr_o <= `NOPRegAddr;
		reg2_addr_o <= `NOPRegAddr;
		imm <= 32'h0;
	end else begin
		aluop_o <= `EXE_NOP_OP;
		alusel_o <= `EXE_RES_NOP;
		wd_o <= inst_i[15:11];
		wreg_o <= `WriteDisable;
		instvalid <= `InstInvalid;
		regl_read_o <= 1'b0;
		reg2_read_o <= 1'b0;
		regl_addr_o <= inst_i[25:21];
		reg2_addr_o <= inst_i[20:16];
		imm <= `ZeroWord;

		case (op)
			`EXE_ORI:	begin
				wreg_o <= `WriteEnable;	
				aluop_o <= `EXE_OR_OP;
				alusel_o <= `EXE_RES_LOGIC;
				regl_read_o <= 1'bl;
				reg2_read_o <= 1'b0;
				imm <= {16'h0, inst i[15:O]};
				wd_o <= inst i[20:16];
				instvalid <= `InstValid;
			end
		default:begin
		end
		endcase
	end
end

//Part2:
pass 
//Part3:
pass		