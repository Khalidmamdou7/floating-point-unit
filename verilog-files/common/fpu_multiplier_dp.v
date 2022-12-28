module fpu_multiplier_dp #(parameter WIDTH=64) (input [WIDTH-1:0] A,input [WIDTH-1:0] B
,output reg [WIDTH-1:0] result);

reg A_sign,B_sign,sign;
reg [52:0] A_Mantissa,B_Mantissa;
reg [51:0] Mantissa;
reg [105:0] Temp_Mantissa;
reg [10:0] A_Exponent,B_Exponent,Temp_Exponent,diff_Exponent,Exponent;

always @(*) begin

A_Mantissa={1'b1,A[51:0]};
A_Exponent=A[62:52];
A_sign=A[63];

B_Mantissa={1'b1,B[51:0]};
B_Exponent=B[62:52];
B_sign=B[63];

Temp_Exponent=A_Exponent+B_Exponent-1023;
Temp_Mantissa=A_Mantissa*B_Mantissa;

Mantissa=Temp_Mantissa[105] ? Temp_Mantissa[104:53] : Temp_Mantissa[103:52];
//if (Temp_Mantissa[47] && Temp_Mantissa[23])
	//Mantissa=Mantissa+1'b1;
//if (!Temp_Mantissa[47] && Temp_Mantissa[22])
	//Mantissa=Mantissa+1'b1;	
	
Exponent= Temp_Mantissa[105] ? Temp_Exponent+1'b1 :Temp_Exponent;
sign=A_sign^B_sign;
result={sign,Exponent,Mantissa};

end

endmodule 