module tb_fpu_sp_comparator();

    // Inputs
    reg signed [7:0] a;
    reg signed [7:0] b;
    
    // Outputs
    wire unsigned [7:0] difference;
    wire sign;
    wire overflow;
    
    // Instantiate the Unit Under Test (UUT)
    fpu_comparator #(.size(8)) uut (
        .a(a),
        .b(b),
        .difference(difference),
        .sign(sign),
        .overflow(overflow)
    );
    
    initial begin
        $display("\ta \t b \t diff \t exp_d \t sign \t exp_s \t of \t exp_of");
        $display("---------------------------------------------------------------------");

        a = 0; b = 0;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 0, sign, 0, overflow, 0);
        a = 0; b = 1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 1, sign, 1, overflow, 0);
        a = 1; b = 0;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 1, sign, 0, overflow, 0);
        a = 1; b = 1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 0, sign, 0, overflow, 0);
        a = 0; b = 2;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 2, sign, 1, overflow, 0);
        a = 2; b = 0;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 2, sign, 0, overflow, 0);
        a = -1; b = 0;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 1, sign, 1, overflow, 0);
        a = 0; b = -1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 1, sign, 0, overflow, 0);
        a = -1; b = 1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 2, sign, 1, overflow, 0);
        a = 1; b = -1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 2, sign, 0, overflow, 0);

        a = 0; b = 127;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 127, sign, 1, overflow, 0);
        a = 127; b = 0;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 127, sign, 0, overflow, 0);
        a = -127; b = 1;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 128, sign, 1, overflow, 1);
        a = 2; b = -127;
        #10 $display("%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d", a, b, difference, 128, sign, 0, overflow, 1);

        $stop;
    end

endmodule