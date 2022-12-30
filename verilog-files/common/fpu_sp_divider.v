module fpu_sp_divider #(parameter WIDTH=32) (input [WIDTH-1:0] A,input [WIDTH-1:0] B, output [WIDTH-1:0] result);

	// A/B = A * 1/B
	wire [WIDTH-1:0] B_reciprocal;

	fpu_sp_reciprocal Recip(B, B_reciprocal);

	fpu_sp_multiplier Mult(A, B_reciprocal, result);
	

endmodule