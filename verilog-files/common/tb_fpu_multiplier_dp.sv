module tb_fpu_multiplier_dp();

  reg [63:0] a, b;
  wire [63:0] c;
  // Instantiate the multiplier module
  fpu_multiplier_dp doublePrecision(a, b, c);

  // Declare variables for the test input values
  real a_real, b_real,c_real,expected_result;

  // Set the test input values and assign them to the input wires
  initial begin
  
		
    a_real = 2234.0132;
    b_real = -1235.3412;
    a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 1: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 37584.0132;
    b_real = 1234;
    a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
    
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 2: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 1.0132;
    b_real = -1235.3412;
    a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation

	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 3: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = -0.0132;
    b_real = -1235.3412;
    a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation

	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 4: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	  a_real = 0.0152;
    b_real = -0.3412;
	a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 5: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	 a_real = 124054.4312345;
    b_real = -9213743.123655343;
	a = $realtobits(a_real);
    b = $realtobits(b_real);
	 #10;
	 c_real=$bitstoreal(c);

  // Wait for a few clock cycles to allow the multiplier to perform the calculation
	 
  // Read the output of the multiplier and compare it to the expected result   
    $display("Test 5: %f * %f = %f \n", a_real, b_real, c_real);
  end


   
endmodule
