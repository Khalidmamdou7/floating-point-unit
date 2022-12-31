module tb_fpu_dp_multiplier #(parameter WIDTH=64);
real A;
real B;
reg [63:0] result;
reg overflow,underflow;
fpu_dp_multiplier Multi($realtobits (A), $realtobits (B), result,overflow,underflow);

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
A = 1.0132;
B = -1235.3412;
#20
A = -0.0132;
B = -1235.3412;
#20
A = 0.0152;
B = -0.3412;
#20
A = 8E-170;
B = 7E-157;
#20
A = 8E170;
B = 7E157;

end

initial
begin
$display("Double Precision Multiplication\n");
#15
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoreal(result));
#20
if(underflow)
$display("UnderFlow\n");
#20
if(overflow)
$display("OverFlow\n");
$finish;
end
endmodule
