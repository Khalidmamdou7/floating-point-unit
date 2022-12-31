module tb_fpu_sp_multiplier #(parameter WIDTH=32);
shortreal A;
shortreal B;
reg [31:0] result;
reg overflow,underflow;
fpu_sp_multiplier Multi($shortrealtobits (A), $shortrealtobits (B), result,overflow,underflow);

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
A = 3E-35;
B = 1E-14;
#20
A = 3E25;
B = 1E14;

end

initial
begin
$display("Single Precision Multiplication\n");
#15
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
$display("A = %f, B = %f, Expected Value = %f, Result = %f\n",A,B,A*B,$bitstoshortreal(result));
#20
if(underflow)
$display("UnderFlow\n");
#20
if(overflow)
$display("OverFlow\n");
$finish;
end
endmodule
