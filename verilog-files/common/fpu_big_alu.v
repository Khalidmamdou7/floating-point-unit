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
    wire [2*WIDTH:0] temp_a;
    wire [2*WIDTH:0] temp_b;
    // concat zeros to the left of the number
    assign temp_a = {WIDTH{1'b0}} + a;
    assign temp_b = {WIDTH{1'b0}} + b;

    wire signed [2*WIDTH:0] a_signed;
    wire signed [2*WIDTH:0] b_signed;
    assign a_signed = a_sign ? -a : a;
    assign b_signed = b_sign ? -b : b;

    // perform the operation
    wire signed [2*WIDTH:0] result;
    assign result = op ? a_signed - b_signed : a_signed + b_signed;

    // convert back to unsigned
    assign extended_result = result < 0 ? -result : result;
    assign result_sign = result[2*WIDTH];

endmodule
