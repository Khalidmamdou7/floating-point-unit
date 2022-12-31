module fpu_sp_reciprocal #(parameter WIDTH=32) (input [WIDTH-1:0] in, output [WIDTH-1:0] result);
	
	//Newton Raphson
	wire [31:0] D;
	assign D = {1'b0, 8'd126, in[22:0]};
	wire overflow_underflow_flag1;
	wire overflow_underflow_flag2;
	wire overflow_underflow_flag3;
	wire overflow_underflow_flag4;
	wire overflow_underflow_flag5;
	wire TempA;
	wire TempB;
	wire TempC;
	wire TempD;
	wire TempE;
	wire TempF;
	wire TempG;
	wire TempH;
	wire TempI;
	wire TempJ;
	wire TempK;
	wire TempL;
	wire TempM;
	wire TempN;
	wire TempO;
	wire TempP;
	wire TempQ;
	wire TempR;

	wire [31:0] C1; //C1 = 48/17
	assign C1 = 32'b01000000001101001011010010110101;
	wire [31:0] C2; //C2 = 32/17
	assign C2 = 32'b00111111111100001111000011110001;
	wire [31:0] C3; //C3 = 2
	assign C3 = 32'b01000000000000000000000000000000;

	wire [31:0] X0;
	wire [31:0] X1;
	wire [31:0] X2;
	wire [31:0] X3;
	wire [31:0] X4;

	wire [31:0] Temp0;
	wire [31:0] Temp1;
	wire [31:0] Temp2;
	wire [31:0] Temp3;
	wire [31:0] Temp4;
	wire [31:0] Temp5;
	wire [31:0] Temp6;
	wire [31:0] Temp7;
	wire [31:0] Temp8;

	//X0 = 48/17 - (32/17 * D)
	fpu_sp_multiplier M0(C2, D, Temp0, TempA, TempB);

	fpu_sp_adder A0(C1, {~Temp0[31], Temp0[30:0]}, X0, overflow_underflow_flag1);
	
	//X1 = X0 (2 - X0 * D)
	fpu_sp_multiplier M11(D, X0, Temp1, TempC, TempD);

	fpu_sp_adder A1(C3, {~Temp1[31], Temp1[30:0]}, Temp2, overflow_underflow_flag2);

	fpu_sp_multiplier M12(X0, Temp2, X1, TempE, TempF);

	//X2 = X1 (2 - X1 * D)
	fpu_sp_multiplier M21(D, X1, Temp3, TempG, TempH);
	
	fpu_sp_adder A2(C3, {~Temp3[31], Temp3[30:0]}, Temp4, overflow_underflow_flag3);

	fpu_sp_multiplier M22(X1, Temp4, X2, TempI, TempJ);
	
	//X3 = X2 (2 - X2 * D)
	fpu_sp_multiplier M31(D, X2, Temp5, TempK, TempL);
	
	fpu_sp_adder A3(C3, {~Temp5[31], Temp5[30:0]}, Temp6, overflow_underflow_flag4);

	fpu_sp_multiplier M32(X2, Temp6, X3, TempM, TempN);
	
	//X4 = X3 (2 - X3 * D)
	fpu_sp_multiplier M41(D, X3, Temp7, TempO, TempP);
	
	fpu_sp_adder A4(C3, {~Temp7[31], Temp7[30:0]}, Temp8, overflow_underflow_flag5);

	fpu_sp_multiplier M42(X3, Temp8, X4, TempQ, TempR);
	
	assign result[31] = in[31];
	assign result[30:23] = X4[30:23] + 8'd126 - in[30:23];
	assign result[22:0] = X4[22:0];

endmodule