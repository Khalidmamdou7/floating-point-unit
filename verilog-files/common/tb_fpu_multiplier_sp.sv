module tb_fpu_multiplier_sp();

  reg [31:0] a, b;
  wire [31:0] c;
  // Instantiate the multiplier module
  fpu_multiplier_sp singlePrecision(a, b, c);

  // Declare variables for the test input values
  shortreal a_real, b_real,c_real,expected_result;

  // Set the test input values and assign them to the input wires
  initial begin
  
		
    a_real = 2234.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 1: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 37584.0132;
    b_real = 1234;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
    
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 2: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 1.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation

	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 3: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = -0.0132;
    b_real = -1235.3412;
    a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation

	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 4: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 0.0152;
    b_real = -0.3412;
	a = $shortrealtobits(a_real);
    b = $shortrealtobits(b_real);
	 #10;
	 c_real=$bitstoshortreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 5: %f * %f = %f \n", a_real, b_real, c_real);
  end


   
endmodule
