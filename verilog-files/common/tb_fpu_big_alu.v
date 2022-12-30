module tb_fpu_big_alu();

    reg op;
    reg [63:0] a;
    reg a_sign;
    reg [63:0] b;
    reg b_sign;
    wire [64:0] c;
    wire c_sign;

    fpu_big_alu #(.WIDTH(64)) uut (
        .op(op),
        .a(a),
        .a_sign(a_sign),
        .b(b),
        .b_sign(b_sign),
        .extended_result(c),
        .result_sign(c_sign)
    );

    initial begin
        a = 64'h0000000000000001;
        a_sign = 0;
        b = 64'h0000000000000001;
        b_sign = 0;
        op = 0;
        #100;
        $display("a = %b", a);
        $display("a_sign = %b", a_sign);
        $display("b = %b", b);
        $display("b_sign = %b", b_sign);
        $display("op = %b", op);
        $display("c = %b", c);
        $display("c_sign = %b", c_sign);

        a = 64'h0000000000000001;
        a_sign = 0;
        b = 64'h0000000000000001;
        b_sign = 1;
        op = 0;
        #100;
        $display("a = %b", a);
        $display("a_sign = %b", a_sign);
        $display("b = %b", b);
        $display("b_sign = %b", b_sign);
        $display("op = %b", op);
        $display("c = %b", c);
        $display("c_sign = %b", c_sign);

        

    end

endmodule