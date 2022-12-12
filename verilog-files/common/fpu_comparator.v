// A generic comparator for the FPU that subtracts two numbers and returns the difference
// input is generic, output is generic

module fpu_comparator #(parameter size = 32)
(
    input signed [size-1:0] a,
    input signed [size-1:0] b,
    output unsigned [size-1:0] difference,
    output sign,
    output overflow
);

    // return the absolute value of the difference
    
    assign difference = (a >= b) ? a - b : b - a;
    assign sign = (a >= b) ? 1'b0 : 1'b1;
    assign overflow = (a[size-1] != b[size-1]) && (a[size-1] != sign);

endmodule