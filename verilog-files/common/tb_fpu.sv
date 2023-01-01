module tb_fpu();

shortreal a,b;
real d,e,f;
reg sp_dp;
reg [1:0] op;
reg [31:0] c;
reg [63:0] c64;
reg overflow;
reg underflow;

fpu uut (
    .sp_dp(sp_dp), // 0 = single precision, 1 = double precision
    .opCode(op), // 0 = add, 1 = sub, 2 = mul, 3 = div
    .a_sp($shortrealtobits(a)),
    .b_sp($shortrealtobits(b)),
    .a_dp($realtobits(d)),
    .b_dp($realtobits(e)),
    .result_sp(c),
    .result_dp(c64),
    .overflow(overflow),
    .underflow(underflow)
);

initial begin
    // Test 1: add two single precision numbers
    sp_dp = 0;
    op = 0;
    a = 1.0;
    b = 2.0;
    #1;
    // Test 2: subtract two single precision numbers
    sp_dp = 0;
    op = 1;
    a = 1.0;
    b = 2.0;
    #1;
    // Test 3: multiply two single precision numbers
    sp_dp = 0;
    op = 2;
    a = 1.0;
    b = 2.0;
    #1;
    // Test 4: divide two single precision numbers
    sp_dp = 0;
    op = 3;
    a = 1.0;
    b = 2.0;
    #1;
    // Test 5: add two double precision numbers
    sp_dp = 1;
    op = 0;
    d = 2121121.123123;
    e = 2121221.123123;
    #1;
    // Test 6: subtract two double precision numbers
    sp_dp = 1;
    op = 1;
    d = 2121121.123123;
    e = 1.21;
    #1;
    // Test 7: multiply two double precision numbers
    sp_dp = 1;
    op = 2;
    d = 2121121.123123;
    e = 1212121.121212;
    #1;
    // Test 8: divide two double precision numbers
    sp_dp = 1;
    op = 3;
    d = 2121121.123123;
    e = 1212121.121212;
    #1;
    // Test 9: check overflow in adding two single precision numbers
    sp_dp = 0;
    op = 0;
    a = 1.2e38;
    b = 1.2e38;
    #1;
    // Test 10: check underflow in adding two single precision numbers
    sp_dp = 0;
    op = 0;
    a = 1.2e-38;
    b = -1.2e-38;
end

    initial begin
        $display("Test 1: add two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        $1;
        $display("Test 2: subtract two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a-b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a-b);
        $1;
        $display("Test 3: multiply two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a*b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a*b);
        $1;
        $display("Test 4: divide two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a/b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a/b);
        $1;
        $display("Test 5: add two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d+e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d+e);
        $1;
        $display("Test 6: subtract two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d-e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d-e);
        $1;
        $display("Test 7: multiply two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d*e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d*e);
        $1;
        $display("Test 8: divide two double precision numbers");
        $display("a = %f", d);
        $display("b = %f", e);
        $display("c = %f", $bitstoreal(c64));
        $display("expected = %f", d/e);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoreal(c64) == d/e);
        $1;
        $display("Test 9: check overflow in adding two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        $1;
        $display("Test 10: check underflow in adding two single precision numbers");
        $display("a = %f", a);
        $display("b = %f", b);
        $display("c = %f", $bitstoshortreal(c));
        $display("expected = %f", a+b);
        $display("overflow = %b", overflow);
        $display("underflow = %b", underflow);
        $display("Pass = %b", $bitstoshortreal(c) == a+b);
        $1;
        $finish;
    end

endmodule