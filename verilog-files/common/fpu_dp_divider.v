module fpu_dp_divider #(parameter WIDTH=64) (
	input [WIDTH-1:0] A,
	input [WIDTH-1:0] B, 
	output [WIDTH-1:0] result, 
	output wire overflow, 
	output wire underflow);

	// A/B = A * 1/B
	wire [WIDTH-1:0] B_reciprocal;

	fpu_dp_reciprocal Recip(B, B_reciprocal);
	wire overflow_mult;
	wire underflow_mult;

	fpu_dp_multiplier Mult(A, B_reciprocal, result, overflow_mult, underflow_mult);

	assign overflow = A[62:52] - B[62:52] > 1023;
	assign underflow = A[62:52] - B[62:52] < -1022;
	

endmodule