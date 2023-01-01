module fpu_dp_adder (
    input [63:0] a,
    input [63:0] b,
    output wire [63:0] result,
    output wire overflow,
    output wire underflow
    );

    wire a_sign;
    wire [51:0] a_mantissa;
    wire [10:0] a_exponent;
    wire b_sign;
    wire [51:0] b_mantissa;
    wire [10:0] b_exponent;
    wire result_sign;
    wire [51:0] result_mantissa;
    wire [10:0] result_exponent;

    assign a_mantissa = a[51:0];
    assign a_exponent = a[62:52];
    assign a_sign = a[63];
    assign b_mantissa = b[51:0];
    assign b_exponent = b[62:52];
    assign b_sign = b[63];

    wire [10:0] exponent_comparator_diff;
    wire exponent_comparator_sign;

    fpu_comparator #(.size(11)) exponent_comparator (
        .a(a_exponent),
        .b(b_exponent),
        .difference(exponent_comparator_diff),
        .sign(exponent_comparator_sign)
    );

    wire [52:0] operand_1_mantissa;
    wire [52:0] operand_2_mantissa;
    wire operand_1_sign;
    wire operand_2_sign;

    // if a_exponent > b_exponent (comp_sign = 0), then operand_1 = a, operand_2 = b

    // concat 1 to the mantissa to account for the hidden bit
    assign operand_1_mantissa = exponent_comparator_sign ? {1'b1, b_mantissa} : {1'b1, a_mantissa};
    assign operand_1_sign = exponent_comparator_sign ? b_sign : a_sign;
    assign operand_2_mantissa = exponent_comparator_sign ? {1'b1, a_mantissa} : {1'b1, b_mantissa};
    assign operand_2_sign = exponent_comparator_sign ? a_sign : b_sign;

    // operand 1 is the larger number and operand 2 is the smaller number
    // we need to shift operand 2's mantissa to the right by the difference in exponents

    wire [52:0] operand_2_mantissa_shifted;
    assign operand_2_mantissa_shifted = operand_2_mantissa >> exponent_comparator_diff[10:0];

    wire [53:0] mantissa_sum;

    fpu_big_alu #(.WIDTH(53)) mantissa_adder (
        .op(1'b0),
        .a(operand_1_mantissa),
        .a_sign(operand_1_sign),
        .b(operand_2_mantissa_shifted),
        .b_sign(operand_2_sign),
        .extended_result(mantissa_sum),
        .result_sign(result_sign)
    );

    wire [10:0] biggest_exponent;
    assign biggest_exponent = exponent_comparator_sign ? b_exponent : a_exponent;

    fpu_normalizer #(.Mantissa_Size(52), .Exponent_Size(11)) mantissa_normalizer (
        .mantissa(mantissa_sum),
        .exponent(biggest_exponent),
        .normalized_mantissa(result_mantissa),
        .normalized_exponent(result_exponent),
        .overflow(overflow),
        .underflow(underflow)
    );

    assign result = {result_sign, result_exponent, result_mantissa};
    
endmodule