module tb_fpu();
localparam PERIOD = 10;

shortreal a,b;
real d,e,f;
reg sp_dp;
reg [1:0] op;
reg [31:0] c;
reg [63:0] c64;
reg overflow;
reg underflow;

reg clk;
reg ready;

fpu uut (
    .clk(clk),
    .sp_dp(sp_dp), // 0 = single precision, 1 = double precision
    .opCode(op), // 0 = add, 1 = sub, 2 = mul, 3 = div
    .a_sp($shortrealtobits(a)),
    .b_sp($shortrealtobits(b)),
    .a_dp($realtobits(d)),
    .b_dp($realtobits(e)),
    .result_sp(c),
    .result_dp(c64),
    .overflow(overflow),
    .underflow(underflow),
    .ready(ready)
);

always begin
	# (PERIOD/2) clk = ~clk;
end

initial begin
    clk = 1'b0;
    // Test 1: add two single precision numbers
    sp_dp = 0;
    op = 0;
    a = 1.0;
    b = 2.0;
    #(PERIOD*3)
    // Test 2: subtract two single precision numbers
    sp_dp = 0;
    op = 1;
    a = 1.0;
    b = 2.0;
    #(PERIOD*3)
    // Test 3: multiply two single precision numbers
    sp_dp = 0;
    op = 2;
    a = 1.0;
    b = 2.0;
    #(PERIOD*3)
    // Test 4: divide two single precision numbers
    sp_dp = 0;
    op = 3;
    a = 1.0;
    b = 2.0;
    #(PERIOD*3)
    // Test 5: add two double precision numbers
    sp_dp = 1;
    op = 0;
    d = 2121121.123123;
    e = 2121221.123123;
    #(PERIOD*3)
    // Test 6: subtract two double precision numbers
    sp_dp = 1;
    op = 1;
    d = 2121121.123123;
    e = 1.21;
    #(PERIOD*3)
    // Test 7: multiply two double precision numbers
    sp_dp = 1;
    op = 2;
    d = 2121121.123123;
    e = 1212121.121212;
    #(PERIOD*3)
    // Test 8: divide two double precision numbers
    sp_dp = 1;
    op = 3;
    d = 2121121.123123;
    e = 1212121.121212;
    #(PERIOD*3)
    // (intensive test for adder sp)
    sp_dp = 0;
    op = 0;
    a = 4.20;  
    b = 3.20;  
    #(PERIOD*3)
    a = 0.66; 
    b = 0.51;  
    #(PERIOD*3)
    a = -6.40; 
    b = -0.50; 
    #(PERIOD*3)
    a = 6.40;  
    b = -0.50;  	
    #(PERIOD*3)
    a = 2.82; 
    b = -0.94; 
    #(PERIOD*3)
    a = 2234.0132;
    b = -1235.3412;
    #(PERIOD*3)
    a = 1.0132;
    b = -1235.3412;
    #(PERIOD*3)
    a = -0.0132;
    b = -1235.3412;
    #(PERIOD*3)
    a = 0.0152;
    b = -0.3412;
    #(PERIOD*3)
    a = 124054.4312345;
    b = -9213743.123655343;
    #(PERIOD*3)
    a= 121.3232;
    b= -123.1231;
    #(PERIOD*3)
    // Overflow Test
    a= 2.21E38;
    b= 2.21E38;
    #(PERIOD*3)
    // Underflow Test
    a= 2.21E-38;
    b = -2.2E-38;
end

    initial begin
        #(PERIOD*2)
        $display("Testing single precision FPU");
        $display("Test 1: add two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("Test 2: subtract two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64)); 
        $display("expected = %f", a-b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a-b);
        #(PERIOD*3)
        $display("Test 3: multiply two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a*b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a*b);
        #(PERIOD*3)
        $display("Test 4: divide two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a/b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        #(PERIOD*3)
        $display("Testing double precision FPU");
        $display("Test 5: add two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d+e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d+e);
        #(PERIOD*3)
        $display("Test 6: subtract two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d-e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d-e);
        #(PERIOD*3)
        $display("Test 7: multiply two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d*e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        #(PERIOD*3)
        $display("Test 8: divide two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d/e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        #(PERIOD*3)
        $display("Intensive testing of all operations");
        $display("Intensive testing of addition of two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        #(PERIOD*3)
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("c64 = %f", $bitstoreal(c64));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        // $display("Test 9: check overflow in adding two single precision numbers");
        // $display("a = %f", a);
        // $display("b = %f", b);
        // $display("c = %f", $bitstoshortreal(c));
        // $display("expected = %f", a+b);
        // $display("overflow = %b", overflow);
        // $display("underflow = %b", underflow);
        // $display("Pass = %b", $bitstoshortreal(c) == a+b);
        // #(PERIOD*3)
        // $display("Test 10: check underflow in adding two single precision numbers");
        // $display("a = %f", a);
        // $display("b = %f", b);
        // $display("c = %f", $bitstoshortreal(c));
        // $display("expected = %f", a+b);
        // $display("overflow = %b", overflow);
        // $display("underflow = %b", underflow);
        // $display("Pass = %b", $bitstoshortreal(c) == a+b);
        // #(PERIOD*3)
        $finish;
    end

endmodule