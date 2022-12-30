module fpu_sp_adder (
    input [31:0] a,
    input [31:0] b,
    output wire [31:0] result,
    output wire overflow_underflow_flag
    );

    wire a_sign;
    wire [22:0] a_mantissa;
    wire [7:0] a_exponent;
    wire b_sign;
    wire [22:0] b_mantissa;
    wire [7:0] b_exponent;
    wire result_sign;
    wire [22:0] result_mantissa;
    wire [7:0] result_exponent;


    assign a_mantissa = a[22:0];
    assign a_exponent = a[30:23];
    assign a_sign = a[31];
    assign b_mantissa = b[22:0];
    assign b_exponent = b[30:23];
    assign b_sign = b[31];

    wire [7:0] exponent_comparator_diff;
    wire exponent_comparator_sign;
    wire exponent_comparator_overflow;

    fpu_comparator #(.size(8)) exponent_comparator (
        .a(a_exponent),
        .b(b_exponent),
        .difference(exponent_comparator_diff),
        .sign(exponent_comparator_sign),
        .overflow(exponent_comparator_overflow)
    );

    wire [22:0] operand_1_mantissa;
    wire [22:0] operand_2_mantissa;
    wire operand_1_sign;
    wire operand_2_sign;

    // if a_exponent > b_exponent (comp_sign = 0), then operand_1 = a, operand_2 = b

    assign operand_1_mantissa = exponent_comparator_sign ? b_mantissa : a_mantissa;
    assign operand_1_sign = exponent_comparator_sign ? b_sign : a_sign;
    assign operand_2_mantissa = exponent_comparator_sign ? a_mantissa : b_mantissa;
    assign operand_2_sign = exponent_comparator_sign ? a_sign : b_sign;

    // operand 1 is the larger number and operand 2 is the smaller number
    // we need to shift operand 2's mantissa to the right by the difference in exponents

    wire [22:0] operand_2_mantissa_shifted;
    assign operand_2_mantissa_shifted = operand_2_mantissa >> exponent_comparator_diff;

    wire [23:0] result_mantissa_extended;
    
    fpu_big_alu #(.WIDTH(23)) mantissa_adder (
        .op(1'b0), // 0 = add, 1 = subtract
        .a(operand_1_mantissa),
        .a_sign(operand_1_sign),
        .b(operand_2_mantissa_shifted),
        .b_sign(operand_2_sign),
        .extended_result(result_mantissa_extended),
        .result_sign(result_sign)
    );

    wire [7:0] biggest_exponent;
    assign biggest_exponent = exponent_comparator_sign ? b_exponent : a_exponent;

    fpu_normalizer #(.Mantissa_Size(23), .Exponent_Size(8)) mantissa_normalizer (
        .mantissa(result_mantissa_extended),
        .exponent(biggest_exponent),
        .normalized_mantissa(result_mantissa),
        .normalized_exponent(result_exponent),
        .overflow_underflow_flag(overflow_underflow_flag)
    );

    assign result = {result_sign, result_exponent, result_mantissa};

endmodule