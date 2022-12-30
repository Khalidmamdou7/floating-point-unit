module fpu_dp_divider #(parameter WIDTH=64) (input [WIDTH-1:0] A,input [WIDTH-1:0] B, output [WIDTH-1:0] result);

	// A/B = A * 1/B
	wire [WIDTH-1:0] B_reciprocal;

	fpu_dp_reciprocal Recip(B, B_reciprocal);

	fpu_dp_multiplier Mult(A, B_reciprocal, result);
	

endmodule