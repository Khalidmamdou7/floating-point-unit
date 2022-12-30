module tb_fpu_sp_adder();

    reg [31:0] a, b;
    wire [31:0] c;
    wire overflow_underflow_flag;

    fpu_sp_adder uut (
        .a(a),
        .b(b),
        .result(c),
        .overflow_underflow_flag(overflow_underflow_flag)
    );

    initial begin
        a = 32'b10001000001000000000000000010000;
        b = 32'b10001000001000000000000000010000;
        #100;
        $display("a = %b", a);
        $display("b = %b", b);
        $display("c = %b", c);
        $display("overflow_underflow_flag = %b", overflow_underflow_flag);


    end

endmodule