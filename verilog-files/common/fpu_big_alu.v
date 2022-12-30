// A generic integer alu that performs arithmetic operations on two numbers (add, subtract)

module fpu_big_alu #(parameter WIDTH=64) (
    input op, // 0: add, 1: subtract
    input [WIDTH-1:0] a,
    input a_sign,
    input [WIDTH-1:0] b,
    input b_sign,
    output wire [WIDTH:0] extended_result,
    output wire result_sign
    );

    // convert to signed
    wire [WIDTH-1:0] a_signed;
    wire [WIDTH-1:0] b_signed;
    assign a_signed = a_sign ? -a : a;
    assign b_signed = b_sign ? -b : b;

    // perform the operation
    wire [WIDTH:0] extended_result_signed;
    assign extended_result_signed = op ? a_signed - b_signed : a_signed + b_signed;

    // convert back to unsigned
    assign extended_result = extended_result_signed[WIDTH] ? -extended_result_signed : extended_result_signed;
    assign result_sign = extended_result_signed[WIDTH];

endmodule
