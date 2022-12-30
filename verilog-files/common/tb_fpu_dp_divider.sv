module tb_fpu_dp_divider #(parameter WIDTH=64);
real A;
real B;
reg [63:0] result;
fpu_dp_divider Div ($realtobits (A), $realtobits (B), result);

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
end

initial
begin
$display("Double Precision Division\n");
#15
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A/B,$bitstoreal(result));
$finish;
end
endmodule
