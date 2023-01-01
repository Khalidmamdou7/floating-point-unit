module fpu_sp_divider #(parameter WIDTH=32) (
	input [WIDTH-1:0] A,
	input [WIDTH-1:0] B, 
	output [WIDTH-1:0] result,
	output wire overflow,
	output wire underflow
	);

	// A/B = A * 1/B
	wire [WIDTH-1:0] B_reciprocal;

	fpu_sp_reciprocal Recip(B, B_reciprocal);

		wire overflow_mult;
	wire underflow_mult;


	fpu_sp_multiplier Mult(A, B_reciprocal, result, overflow_mult, underflow_mult);
	
	wire [7:0] exponent_result;
	assign exponent_result = A[30:23] - B[30:23];
	
	assign overflow = exponent_result[7] & ~exponent_result[6:0];
	assign underflow = ~exponent_result[7] & exponent_result[6:0];
	

endmodule