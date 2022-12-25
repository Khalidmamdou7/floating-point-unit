module fpu_multiplier_sp #(parameter WIDTH=32) (input [WIDTH-1:0] A,input [WIDTH-1:0] B
,output reg [WIDTH-1:0] result);

reg A_sign,B_sign,sign;
reg [23:0] A_Mantissa,B_Mantissa;
reg [22:0] Mantissa;
reg [47:0] Temp_Mantissa;
reg [7:0] A_Exponent,B_Exponent,Temp_Exponent,diff_Exponent,Exponent;
reg [32:0] Temp;
reg[6:0] x;

always @(*) begin

A_Mantissa={1'b1,A[22:0]};
A_Exponent=A[30:23];
A_sign=A[31];

B_Mantissa={1'b1,B[22:0]};
B_Exponent=B[30:23];
B_sign=B[31];

Temp_Exponent=A_Exponent+B_Exponent-127;
Temp_Mantissa=A_Mantissa*B_Mantissa;

Mantissa=Temp_Mantissa[47] ? Temp_Mantissa[46:24] : Temp_Mantissa[45:23];
//if (Temp_Mantissa[47] && Temp_Mantissa[23])
	//Mantissa=Mantissa+1'b1;
//if (!Temp_Mantissa[47] && Temp_Mantissa[22])
	//Mantissa=Mantissa+1'b1;	
	
Exponent= Temp_Mantissa[47] ? Temp_Exponent+1'b1 :Temp_Exponent;
sign=A_sign^B_sign;
result={sign,Exponent,Mantissa};

end

endmodule 