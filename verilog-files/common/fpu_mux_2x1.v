// A generic 2x1 multiplexer

module fpu_mux_2x1 #(parameter size = 32)
(
    input select,
    input [size-1:0] a,
    input [size-1:0] b,
    output [size-1:0] out
);

    assign out = select ? b : a;

endmodule