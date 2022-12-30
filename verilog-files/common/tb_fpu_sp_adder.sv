module tb_fpu_sp_adder();

    reg [31:0] a, b;
    wire [31:0] c;
    wire overflow_underflow_flag;

    fpu_sp_adder uut (
        .a(a),
        .b(b),
        .result(c),
        .overflow_underflow_flag(overflow_underflow_flag)
    );
    shortreal a_real, b_real, c_real, expected_c_real;
    wire isCorrect;

    assign isCorrect = (c_real == a_real + b_real);

    initial begin
        a_real = 1.0;
        b_real = 2.0;
        a = $shortreal_to_real(a_real);
        b = $shortreal_to_real(b_real);
        #10;
        c_real = $real_to_shortreal(c);
        expected_c_real = a_real + b_real;
        $display("a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

    //     a_real = 1.0;
    //     b_real = -2.0;
    //     a = $shortreal_to_real(a_real);
    //     b = $shortreal_to_real(b_real);
    //     #10;
    //     c_real = $real_to_shortreal(c);
    //     $display("a = %f, b = %f, c = %f, expected_c = %f", a_real, b_real, c_real, a_real + b_real);

    //     a_real = -1.0;
    //     b_real = 2.0;
    //     a = $shortreal_to_real(a_real);
    //     b = $shortreal_to_real(b_real);
    //     #10;
    //     c_real = $real_to_shortreal(c);
    //     $display("a = %f, b = %f, c = %f, expected_c = %f", a_real, b_real, c_real, a_real + b_real);

    //     a_real = -1.0;
    //     b_real = -2.0;
    //     a = $shortreal_to_real(a_real);
    //     b = $shortreal_to_real(b_real);
    //     #10;
    //     c_real = $real_to_shortreal(c);
    //     $display("a = %f, b = %f, c = %f, expected_c = %f", a_real, b_real, c_real, a_real + b_real);

    //     a_real = 2234.0132;
    //     b_real = -1235.3412;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
	//     #10;
	//     c_real=$bitstoshortreal(c); 
    //     $display("Test 1: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
	//     a_real = 37584.0132;
    //     b_real = 1234;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
	//     #10;
	//     c_real=$bitstoshortreal(c);  
    //     $display("Test 2: %f * %f = %f \n", a_real, b_real, c_real);
	 
	 
    //     a_real = 1.0132;
    //     b_real = -1235.3412;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
    //     #10;
    //     c_real=$bitstoshortreal(c);  
    //     $display("Test 3: %f * %f = %f \n", a_real, b_real, c_real);
        
        
    //     a_real = -0.0132;
    //     b_real = -1235.3412;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
    //     #10;
    //     c_real=$bitstoshortreal(c);
    //     $display("Test 4: %f * %f = %f \n", a_real, b_real, c_real);
        
        
    //     a_real = 0.0152;
    //     b_real = -0.3412;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
    //     #10;
    //     c_real=$bitstoshortreal(c); 
    //     $display("Test 5: %f * %f = %f \n", a_real, b_real, c_real);
	 
    //     a_real = 124054.4312345;
    //     b_real = -9213743.123655343;
    //     a = $shortrealtobits(a_real);
    //     b = $shortrealtobits(b_real);
    //     #10;
    //     c_real=$bitstoshortreal(c);   
    //     $display("Test 6: %f * %f = %f \n", a_real, b_real, c_real);
	 
        $finish;
    end

endmodule