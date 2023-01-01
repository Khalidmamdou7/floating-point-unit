module fpu_sp_divider #(parameter WIDTH=32) (
	input [WIDTH-1:0] A,
	input [WIDTH-1:0] B, 
	output [WIDTH-1:0] result,
	output wire overflow,
	output wire underflow
	);

	// A/B = A * 1/B
	wire [WIDTH-1:0] B_reciprocal;
	wire Overflow;
	wire Underflow;
	assign overflow_underflow_flag = Overflow | Underflow;

	fpu_sp_reciprocal Recip(B, B_reciprocal);

	fpu_sp_multiplier Mult(A, B_reciprocal, result, Overflow, Underflow);
	

endmodule