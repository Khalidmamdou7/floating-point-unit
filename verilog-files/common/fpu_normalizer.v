// A generic fpu normalizer that performs normalization on an fpu number

module fpu_normalizer #(parameter Mantissa_Size=23, parameter Exponent_Size=8) (
    input [Mantissa_Size+1:0] mantissa,
    input [Exponent_Size-1:0] exponent,
    output wire [Mantissa_Size-1:0] normalized_mantissa,
    output wire [Exponent_Size-1:0] normalized_exponent,
    output wire overflow,
    output wire underflow
    );

    // if mantissa[Mantissa_Size] is 1, then shift right by 1 and increment exponent
    // if mantissa[Mantissa_Size-1] is 0, then shift left by 1 and decrement exponent till mantissa[Mantissa_Size-1] is 1

    reg [Mantissa_Size+1:0] temp_mantissa;
    reg [Exponent_Size-1:0] temp_exponent;
    reg temp_overflow;
    reg temp_underflow;

    // create a counter to use it in the loop
    reg [Mantissa_Size-1:0] counter;

    always @(*) begin
        temp_mantissa = mantissa;
        temp_exponent = exponent;
        if (mantissa[Mantissa_Size+1] == 1) begin
            temp_mantissa = mantissa >> 1;
            temp_exponent = exponent + 1;
        end
        else begin
            counter = 0;
            while (temp_exponent != 0 && temp_mantissa[Mantissa_Size] == 0 && counter != Mantissa_Size) begin
                if (temp_mantissa != 0) begin
                    temp_mantissa = temp_mantissa << 1;
                    temp_exponent = temp_exponent - 1;
                end
                counter = counter + 1;
            end
        end
        temp_overflow = 0;
        temp_underflow = 0;
        if (temp_exponent == 0) begin
            temp_underflow = 1;
        end
        else if (temp_exponent == (1 << Exponent_Size) - 1) begin
            temp_overflow = 1;
        end
        
    end
    // Overflow and underflow flag will be triggered if the exponent is smaller than 1 or greater than 254
    // 1 is the smallest exponent that can be represented in the fpu
    // 254 is the largest exponent that can be represented in the fpu
    // check if the exponent after normalization is all 1s or all 0s
    assign overflow = temp_overflow;
    assign underflow = temp_underflow;
    assign normalized_mantissa = temp_mantissa[Mantissa_Size-1:0];
    assign normalized_exponent = temp_exponent;

endmodule