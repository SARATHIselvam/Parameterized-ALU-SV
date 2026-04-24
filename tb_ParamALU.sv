import alu_pkg::*;
module tb_ParamALU;

    parameter WIDTH = 32;

    reg  [WIDTH-1:0] A, B;
    alu_op op;   
    wire [WIDTH-1:0] result;
    wire C, V, Z, N;


    ParamALU #(WIDTH) dut (
        .A(A),
        .B(B),
        .op(op),
        .result(result),
        .C(C),
        .V(V),
        .Z(Z),
        .N(N)
    );

    

    integer i;
    alu_op ops [0:11];

    initial begin
        ops[0]  = ALU_ADD;
        ops[1]  = ALU_SUB;
        ops[2]  = ALU_AND;
        ops[3]  = ALU_OR;
        ops[4]  = ALU_XOR;
        ops[5]  = ALU_SLL;
        ops[6]  = ALU_SRL;
        ops[7]  = ALU_SLT;
        ops[8]  = ALU_SRA;
        ops[9]  = ALU_NOR;
        ops[10] = ALU_EQ;
        ops[11] = ALU_NE;
    end

    initial begin
        A = 0;
        B = 0;
        op = ALU_ADD;

        #10;

        for (i = 0; i < 12; i = i + 1) begin
            A = $random;
            B = $random;
            op = ops[i];
            #10;
        end

        A = 0; B = 1; op = ALU_ADD;
        #10;

        A = 32'h8000_0000; B = 1; op = ALU_ADD;
        #10;

        A = 32'hFFFF_FFFF; B = 32'h0000_0001; op = ALU_ADD;
        #10;

        $stop;
    end

endmodule
