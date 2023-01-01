module fpu_dp #(parameter WIDTH=64) (
	input [WIDTH-1:0] A, 
	input [WIDTH-1:0] B,
	input clk,	
	input [1:0] OpCode,	
	output [WIDTH-1:0] Result,
	output Ready,
	output Overflow_out,
	output Underflow_out
	);
	
wire Overflow_Add;
wire Underflow_Add;
wire Overflow_Sub;
wire Underflow_Sub;
wire Overflow_Mul;
wire Underflow_Mul;
wire Overflow_Div;
wire Underflow_Div;
	
reg [63:0] Adder_A;
reg [63:0] Adder_B;
wire [63:0] Adder_Result;

reg [63:0] Subtractor_A;
reg [63:0] Subtractor_B;
wire [63:0] Subtractor_Result;

reg [63:0] Multiplier_A;
reg [63:0] Multiplier_B;
wire [63:0] Multiplier_Result;

reg [63:0] Divider_A;
reg [63:0] Divider_B;
wire [63:0] Divider_Result;

reg [63:0] Output;
reg Overflow;
reg Underflow;

wire [63:0] posZero;
assign posZero = 64'b0000000000000000000000000000000000000000000000000000000000000000;

wire [63:0] negZero;
assign negZero = 64'b1000000000000000000000000000000000000000000000000000000000000000;

wire [63:0] posINF;
assign posINF = 64'b0111111111110000000000000000000000000000000000000000000000000000;

wire [63:0] negINF;
assign negINF = 64'b1111111111110000000000000000000000000000000000000000000000000000;

wire [63:0] NaN;
assign NaN = 64'bX111111111111XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;

assign Result = Output;
assign Overflow_out = Overflow;
assign Underflow_out = Underflow;

assign ADD = !OpCode[1] & !OpCode[0];
assign SUB = !OpCode[1] & OpCode[0];
assign MUL = OpCode[1] & !OpCode[0];	
assign DIV = OpCode[1] & OpCode[0];

fpu_dp_adder Adder_FPU(Adder_A, Adder_B, Adder_Result, Overflow_Add, Underflow_Add);
fpu_dp_adder Subtractor_FPU(Subtractor_A, Subtractor_B, Subtractor_Result, Overflow_Sub, Underflow_Sub);
fpu_dp_multiplier Multiplier_FPU(Multiplier_A, Multiplier_B, Multiplier_Result, Overflow_Mul, Underflow_Mul);
fpu_dp_divider Divider_FPU(Divider_A, Divider_B, Divider_Result, Overflow_Div, Underflow_Div);

always @ (posedge clk) begin
	if (A == NaN || B == NaN) begin
		Output = NaN;
	end else if (ADD) begin
		if ((A == posINF || A == negINF) && (B == posINF || B == negINF)) begin
			Output = NaN;
		end else if ((A == posINF || A == negINF) && (B != posINF || B != negINF)) begin
			Output = {A[63], posINF[62:0]};
		end else if ((B == posINF || B == negINF) && (A != posINF || A != negINF)) begin
			Output = {B[63], posINF[62:0]};
		end else begin
			Adder_A = A;
			Adder_B = B;
			Output = Adder_Result;
			Overflow = Overflow_Add;
			Underflow = Underflow_Add;
		end
	end else if (SUB) begin
		if ((A == posINF || A == negINF) && (B == posINF || B == negINF)) begin
			Output = NaN;
		end else if ((A == posINF || A == negINF) && (B != posINF || B != negINF)) begin
			Output = {A[63], posINF[62:0]};
		end else if ((B == posINF || B == negINF) && (A != posINF || A != negINF)) begin
			Output = {~B[63], posINF[62:0]};
		end else begin
			Subtractor_A = A;
			Subtractor_B = {~B[63], B[62:0]};
			Output = Subtractor_Result;
			Overflow = Overflow_Sub;
			Underflow = Underflow_Sub;
		end
	end else if (MUL) begin
		if ((A == posZero || A == negZero) && (B == posINF || B == negINF)) begin
			Output = NaN;
		end else if ((A == posINF || A == negINF) && (B == posZero || B == negZero)) begin
			Output = NaN;
		end else if (A == posZero || A == negZero || B == posZero || B == negZero) begin
			Output[63] = A[63] ^ B[63];
			Output[62:0] = posZero[62:0];
		end else if ((A != posZero || A != negZero) && B == posINF) begin
			Output = posINF;
		end else if ((A != posZero || A != negZero) && B == negINF) begin
			Output = negINF;
		end else if ((B != posZero || B != negZero) && A == posINF) begin
			Output = posINF;
		end else if ((B != posZero || B != negZero) && A == negINF) begin
			Output = negINF;
		end else begin
			Multiplier_A = A;
			Multiplier_B = B;
			Output = Multiplier_Result;
			Overflow = Overflow_Mul;
			Underflow = Underflow_Mul;
		end
	end else if (DIV) begin
		if ((A != posZero && A != negZero) && B == posZero) begin
			Output = posINF;
		end else if ((A != posZero && A != negZero) && B == negZero) begin
			Output = negINF;
		end else if ((A == posZero || A == negZero) && (B == posZero || B == negZero)) begin
			Output = NaN;
		end else if ((A == posINF || A == negINF) && (B == posINF || B == negINF)) begin
			Output = NaN;
		end else if ((A != posINF || A != negINF) && B == posINF) begin
			Output = posINF;
		end else if ((A != posINF || A != negINF) && B == negINF) begin
			Output = negINF;
		end else begin
			Divider_A = A;
			Divider_B = B;
			Output = Divider_Result;
			Overflow = Overflow_Div;
			Underflow = Underflow_Div;
		end
	end
end
				
endmodule			