module tb_fpu_normalizer();

// Testbench for fpu_normalizer

reg [23:0] mantissa;
reg [7:0] exponent;
reg [22:0] normalized_mantissa;
reg [7:0] normalized_exponent;
wire overflow;
wire underflow;

fpu_normalizer fpu_normalizer_inst (
    .mantissa(mantissa),
    .exponent(exponent),
    .normalized_mantissa(normalized_mantissa),
    .normalized_exponent(normalized_exponent),
    .overflow(overflow),
    .underflow(underflow)
);

initial begin
    // Test 1
    mantissa = 24'b000000000000000000000001;
    exponent = 0;
    #100;
    // Test 2
    mantissa = 24'b000000000000000000000001;
    exponent = 1;
    #100;
    // Test 3
    mantissa = 24'b000000000000000000000010;
    exponent = 2;
    #100;
    // Test 4
    mantissa = 24'b000100000000000000000000;
    exponent = 3;
    #100;
    // Test 5
    mantissa = 24'b010000000000000000000000;
    exponent = 4;
    #100;
    // Test 6
    mantissa = 24'b100000000000000000000000;
    exponent = 5;
    #100;
    $finish;
end

endmodule