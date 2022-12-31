module fpu_dp_multiplier #(parameter WIDTH=64) (input [WIDTH-1:0] A,input [WIDTH-1:0] B
,output wire [WIDTH-1:0] result,output wire overflow,output wire underflow);

wire A_sign,B_sign,sign,zero;
wire [52:0] A_Mantissa,B_Mantissa;
wire [51:0] Mantissa;
wire [105:0] Temp_Mantissa;
wire [10:0] A_Exponent,B_Exponent;
wire [11:0] Temp_Exponent,Exponent;

assign A_Exponent=A[62:52];
assign A_sign=A[63];

assign B_Exponent=B[62:52];
assign B_sign=B[63];

 //Normal Operation
 
 // XOR of Sign Bit
 assign sign=A_sign^B_sign;
 //If Exponent = 0, first bit = 0 
 assign A_Mantissa=(|A_Exponent) ? {1'b1,A[51:0]} : {1'b0,A[51:0]};
 assign B_Mantissa=(|B_Exponent) ? {1'b1,B[51:0]} : {1'b0,B[51:0]};
 //Product of Mantissas
 assign Temp_Mantissa=A_Mantissa*B_Mantissa; 
 //Normalization
 assign Mantissa=Temp_Mantissa[105] ? Temp_Mantissa[104:53] : Temp_Mantissa[103:52];

 //Check for zero Mantissa
 assign zero = (Mantissa==52'd0) ?1'b1:1'b0;
 //Exponent
 assign Temp_Exponent=A_Exponent+B_Exponent-1023;
 assign Exponent= Temp_Mantissa[105] ? Temp_Exponent+1'b1 :Temp_Exponent;
 
 //OverFlow & UnderFlow
 assign overflow = ((Exponent[11] & !Exponent[10]) &!zero) ? 1'b1:1'b0;
 assign underflow= ((Exponent[11] & Exponent[10]) &!zero)  ? 1'b1:1'b0;
 //Result
 assign result = overflow ? {sign,11'b11111111111,52'd0} 
 : underflow ? {sign,63'd0} : {sign,Exponent[10:0],Mantissa};

endmodule 