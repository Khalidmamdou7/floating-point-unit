module fpu_dp_reciprocal #(parameter WIDTH=64) (input [WIDTH-1:0] in, output [WIDTH-1:0] result);
	
	//Newton Raphson
	wire [63:0] D;
	assign D = {1'b0, 11'd1022, in[51:0]};
	wire overflow_underflow_flag;

	wire [63:0] C1; //C1 = 48/17
	assign C1 = 64'b0100000000000110100101101001011010010110100101101001011010010111;
	wire [63:0] C2; //C2 = 32/17
	assign C2 = 64'b0011111111111110000111100001111000011110000111100001111000011110;
	wire [63:0] C3; //C3 = 2
	assign C3 = 64'b0100000000000000000000000000000000000000000000000000000000000000;

	wire [63:0] X0;
	wire [63:0] X1;
	wire [63:0] X2;
	wire [63:0] X3;
	wire [63:0] X4;
	wire [63:0] X5;
	wire [63:0] X6;

	wire [63:0] Temp0;
	wire [63:0] Temp1;
	wire [63:0] Temp2;
	wire [63:0] Temp3;
	wire [63:0] Temp4;
	wire [63:0] Temp5;
	wire [63:0] Temp6;
	wire [63:0] Temp7;
	wire [63:0] Temp8;
	wire [63:0] Temp9;
	wire [63:0] Temp10;
	wire [63:0] Temp11;
	wire [63:0] Temp12;
	
	//X0 = 48/17 - (32/17 * D)
	fpu_dp_multiplier M0(C2, D, Temp0);

	fpu_dp_adder A0(C1, {~Temp0[63], Temp0[62:0]}, X0, overflow_underflow_flag);
	
	//X1 = X0 (2 - X0 * D)
	fpu_dp_multiplier M11(D, X0, Temp1);

	fpu_dp_adder A1(C3, {~Temp1[63], Temp1[62:0]}, Temp2, overflow_underflow_flag);

	fpu_dp_multiplier M12(X0, Temp2, X1);

	//X2 = X1 (2 - X1 * D)
	fpu_dp_multiplier M21(D, X1, Temp3);
	
	fpu_dp_adder A2(C3, {~Temp3[63], Temp3[62:0]}, Temp4, overflow_underflow_flag);

	fpu_dp_multiplier M22(X1, Temp4, X2);
	
	//X3 = X2 (2 - X2 * D)
	fpu_dp_multiplier M31(D, X2, Temp5);
	
	fpu_dp_adder A3(C3, {~Temp5[63], Temp5[62:0]}, Temp6, overflow_underflow_flag);

	fpu_dp_multiplier M32(X2, Temp6, X3);
	
	//X4 = X3 (2 - X3 * D)
	fpu_dp_multiplier M41(D, X3, Temp7);
	
	fpu_dp_adder A4(C3, {~Temp7[63], Temp7[62:0]}, Temp8, overflow_underflow_flag);

	fpu_dp_multiplier M42(X3, Temp8, X4);
	
	//X5 = X4 (2 - X4 * D)
	fpu_dp_multiplier M51(D, X4, Temp9);
	
	fpu_dp_adder A5(C3, {~Temp9[63], Temp9[62:0]}, Temp10, overflow_underflow_flag);

	fpu_dp_multiplier M52(X4, Temp10, X5);
	
	//X6 = X5 (2 - X5 * D)
	fpu_dp_multiplier M61(D, X5, Temp11);
	
	fpu_dp_adder A6(C3, {~Temp11[63], Temp11[62:0]}, Temp12, overflow_underflow_flag);

	fpu_dp_multiplier M62(X5, Temp12, X6);
	
	assign result[63] = in[63];
	assign result[62:52] = X6[62:52] + 11'd1022 - in[62:52];
	assign result[51:0] = X6[51:0];

endmodule