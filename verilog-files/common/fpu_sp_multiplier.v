module fpu_sp_multiplier #(parameter WIDTH=32) (
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output wire [WIDTH-1:0] result,
    output wire overflow,output wire underflow);

wire A_sign,B_sign,sign,zero;
wire [23:0] A_Mantissa,B_Mantissa;
wire [22:0] Mantissa;
wire [47:0] Temp_Mantissa;
wire [7:0] A_Exponent,B_Exponent;
wire [8:0] Temp_Exponent,Exponent;

assign A_Exponent=A[30:23];
assign A_sign=A[31];

assign B_Exponent=B[30:23];
assign B_sign=B[31];

 //Normal Operation
 
 // XOR of Sign Bit
 assign sign=A_sign^B_sign;
 //If Exponent = 0, first bit = 0 
 assign A_Mantissa=(|A_Exponent) ? {1'b1,A[22:0]} : {1'b0,A[22:0]};
 assign B_Mantissa=(|B_Exponent) ? {1'b1,B[22:0]} : {1'b0,B[22:0]};
 //Product of Mantissas
 assign Temp_Mantissa=A_Mantissa*B_Mantissa; 
 //Normalization
 assign Mantissa=Temp_Mantissa[47] ? Temp_Mantissa[46:24] : Temp_Mantissa[45:23];

 //Check for zero Mantissa
 assign zero = (Mantissa==23'd0) ? 1'b1 : 1'b0;
 //Exponent
 assign Temp_Exponent=A_Exponent+B_Exponent-127;
 assign Exponent= Temp_Mantissa[47] ? Temp_Exponent+1'b1 :Temp_Exponent;
 
 //OverFlow & UnderFlow
 assign overflow = ((Exponent[8] & !Exponent[7]) & !zero) ? 1'b1:1'b0;
 assign underflow= ((Exponent[8] & Exponent[7]) & !zero)  ? 1'b1:1'b0;
 
 //Result
 assign result = overflow ? {sign,8'b11111111,23'd0} 
 : underflow ? {sign,31'd0} : {sign,Exponent[7:0],Mantissa};

endmodule 