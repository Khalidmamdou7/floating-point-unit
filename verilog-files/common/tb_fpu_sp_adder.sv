module tb_fpu_sp_adder #(parameter WIDTH=32);
shortreal A;
shortreal B;
reg [31:0] result;
wire overflow;
wire underflow;
fpu_sp_adder Add ($shortrealtobits (A), $shortrealtobits (B), result,overflow,underflow);

initial  
begin
A = 4.20;  
B = 3.20;  
#20
A = 0.66; 
B = 0.51;  
#20
A = -6.40; 
B = -0.50; 
#20
A = 6.40;  
B = -0.50;  	
#20
A = 2.82; 
B = -0.94; 
#20
A = 2234.0132;
B = -1235.3412;
#20
A = 1.0132;
B = -1235.3412;
#20
A = -0.0132;
B = -1235.3412;
#20
A = 0.0152;
B = -0.3412;
#20
A = 124054.4312345;
B = -9213743.123655343;
#20
A= 121.3232;
B= -123.1231;
#20
// Overflow Test
A= 2.21E38;
B= 2.21E38;
#20
// Underflow Test
A= 2.21E-38;
B = -2.2E-38;
end

initial
begin
$display("Single Precision Addition\n");
#15
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A+B,$bitstoshortreal(result));
$display("Overflow = %b, Underflow = %b\n",overflow,underflow);
$finish;
end
endmodule
