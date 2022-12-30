module tb_fpu_sp_multiplier();

  reg [31:0] a, b;
  wire [31:0] c;
  
  fpu_sp_multiplier singlePrecision(a, b, c);
  shortreal a_real, b_real,c_real;

  
  initial begin
  
		
    a_real = 2234.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c); 
    $display("Test 1: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 37584.0132;
    b_real = 1234;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);  
    $display("Test 2: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 1.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);  
    $display("Test 3: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = -0.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);
    $display("Test 4: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 0.0152;
    b_real = -0.3412;
	a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c); 
    $display("Test 5: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 a_real = 124054.4312345;
    b_real = -9213743.123655343;
	 a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);   
    $display("Test 6: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	 a_real = 2139095040;
    b_real = 0;
	 a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);  
	 //if(c_real==2147483647)
    $display("Test 7: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 a_real = 2139095040;
    b_real = 0;
	 a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);  
	 if(c_real==2139095040)
    $display("Test 7: INF * 0 = NaN \n");
	 
	 a = 32'b1; //NaN
	 b={1'b1,8'b01101010,23'b10101010101010101010000};
	 #10;
	 if( c ==32'b1)
    $display("Test 9: NaN * Integer = NaN \n");
	 
	  
  end


   
endmodule