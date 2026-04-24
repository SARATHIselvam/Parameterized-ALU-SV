import alu_pkg::*;
module ParamALU #(
	parameter WIDTH = 32
)(
	input logic [WIDTH-1:0] A,B,
	input alu_op op,
	output logic [WIDTH-1:0] result,
	output logic C,
	output logic V,
	output logic Z,
	output logic N
);


logic [WIDTH:0] temp;
logic [$clog2(WIDTH)-1:0] shamt;

assign shamt = B[$clog2(WIDTH)-1:0];

always_comb begin
	temp ='0;
	result ='0;
	C=0;
	V=0;
	
	case(op)
		ALU_ADD: begin
			temp = A+B;
			result = temp[WIDTH-1:0];
			C = temp[WIDTH];
			V = ((A[WIDTH-1:0] == B[WIDTH-1:0])&& (result[WIDTH -1 :0]!= A[WIDTH -1 : 0]));
		end
		ALU_SUB: begin
			temp = A-B;
			result = temp[WIDTH-1:0];
			C = temp[4];
			V = ((A[WIDTH-1:0] == B[WIDTH-1:0])&& (result[WIDTH -1 :0]!= A[WIDTH -1 : 0]));
		end
		ALU_AND: begin
			result = A&B;
		end
		ALU_OR: begin
			result = A|B;
		end
		ALU_XOR: begin
			result = A^B;
		end
		ALU_NOR:begin
			result = ~(A|B);
		end
		ALU_SLL:begin
			result = A<<shamt;
		end
		ALU_SRL:begin
			result = A>>shamt;
		end
		ALU_SLT:begin
			result = ($signed(A)<$signed(B))?1:0;
		end
		ALU_SRA:begin
			result = ($signed(A)>>> shamt);
		end
		ALU_EQ:begin
			result = (A==B)?1:0;
		end
		ALU_NE:begin
			result = (A!=B)?1:0;
		end
		default: result = 0;
		
	endcase
	Z = (result == 0);
   N = result[WIDTH-1];
end
endmodule
