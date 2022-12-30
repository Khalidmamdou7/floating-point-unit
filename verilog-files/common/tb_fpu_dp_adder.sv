module tb_fpu_dp_adder();

    reg [63:0] a, b;
    wire [63:0] c;
    wire overflow_underflow_flag;

    fpu_dp_adder uut (
        .a(a),
        .b(b),
        .result(c),
        .overflow_underflow_flag(overflow_underflow_flag)
    );
    real a_real, b_real, c_real, expected_c_real;
    reg isCorrect;

    initial begin
        a_real = 1.0;
        b_real = 2.0;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #1: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 2.0;
        b_real = 1.0;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #2: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 1.0;
        b_real = -2.0;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #3: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = -1.0;
        b_real = 2.0;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #4: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 121.3232;
        b_real = 123.1231;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #5: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 121.3232;
        b_real = -123.1231;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #6: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = -121.3232;
        b_real = 123.1231;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #7: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 37584.0132;
        b_real = 123.1231;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #8: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 0.002112;
        b_real = -0.002132;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #9: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);

        a_real = 124054.4312345;
        b_real = -9213743.123655343;
        a = $realtobits(a_real);
        b = $realtobits(b_real);
        #10;
        c_real = $bitstoreal(c);
        expected_c_real = a_real + b_real;
        isCorrect = (c_real == expected_c_real);
        $display("Test #10: a = %f, b = %f, c = %f, expected_c = %f, isCorrect = %d", a_real, b_real, c_real, expected_c_real, isCorrect);
	 
        $finish;
    end

endmodule