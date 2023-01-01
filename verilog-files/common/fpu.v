module fpu(
    input sp_dp,    // 0 = single precision, 1 = double precision
    input [1:0] opCode, // 00 = add, 01 = subtract, 10 = multiply, 11 = divide
    input [31:0] a_sp,
    input [31:0] b_sp,
    input [63:0] a_dp,
    input [63:0] b_dp,
    output wire [31:0] result_sp,
    output wire [63:0] result_dp,
    output wire overflow,
    output wire underflow
    );

    wire [31:0] result_sp_adder;
    wire [31:0] result_sp_subtractor;
    wire [31:0] result_sp_multiplier;
    wire [31:0] result_sp_divider;

    wire [63:0] result_dp_adder;
    wire [63:0] result_dp_subtractor;
    wire [63:0] result_dp_multiplier;
    wire [63:0] result_dp_divider;

    wire overflow_underflow_flag_adder_sp;
    wire overflow_underflow_flag_subtractor_sp;
    wire overflow_underflow_flag_adder_dp;
    wire overflow_underflow_flag_subtractor_dp;
    wire overflow_flag_multiplier_sp;
    wire underflow_flag_multiplier_sp;
    wire overflow_flag_multiplier_dp;
    wire underflow_flag_multiplier_dp;
    wire overflow_flag_divider_sp;
    wire underflow_flag_divider_sp;
    wire overflow_flag_divider_dp;
    wire underflow_flag_divider_dp;


    fpu_dp_adder adder (
        .a(a_dp),
        .b(b_dp),
        .result(result_dp_adder),
        .overflow_underflow_flag(overflow_underflow_flag_adder_dp)
    );

    fpu_dp_subtractor subtractor (
        .a(a_dp),
        .b(b_dp),
        .result(result_dp_subtractor),
        .overflow_underflow_flag(overflow_underflow_flag_subtractor_dp)
    );

    fpu_dp_multiplier multiplier (
        .A(a_dp),
        .B(b_dp),
        .result(result_dp_multiplier),
        .overflow(overflow_flag_multiplier_dp),
        .underflow(underflow_flag_multiplier_dp)
    );

    fpu_dp_divider divider (
        .A(a_dp),
        .B(b_dp),
        .result(result_dp_divider),
        .overflow(overflow_flag_divider_dp),
        .underflow(underflow_flag_divider_dp)
    );

    fpu_sp_adder sp_adder (
        .a(a_sp),
        .b(b_sp),
        .result(result_sp_adder),
        .overflow_underflow_flag(overflow_underflow_flag_adder_sp)
    );

    fpu_sp_subtractor sp_subtractor (
        .a(a_sp),
        .b(b_sp),
        .result(result_sp_subtractor),
        .overflow_underflow_flag(overflow_underflow_flag_subtractor_sp)
    );

    fpu_sp_multiplier sp_multiplier (
        .A(a_sp),
        .B(b_sp),
        .result(result_sp_multiplier),
        .overflow(overflow_flag_multiplier_sp),
        .underflow(underflow_flag_multiplier_sp)
    );

    fpu_sp_divider sp_divider (
        .A(a_sp),
        .B(b_sp),
        .result(result_sp_divider),
        .overflow(overflow_flag_divider_sp),
        .underflow(underflow_flag_divider_sp)
    );

    assign result_sp = (opCode == 2'b00 && !sp_dp) ? result_sp_adder :
                       (opCode == 2'b01 && !sp_dp) ? result_sp_subtractor :
                       (opCode == 2'b10 && !sp_dp) ? result_sp_multiplier :
                       (opCode == 2'b11 && !sp_dp) ? result_sp_divider :
                       32'b0;
    
    assign result_dp = (opCode == 2'b00 && sp_dp) ? result_dp_adder :
                          (opCode == 2'b01 && sp_dp) ? result_dp_subtractor :
                          (opCode == 2'b10 && sp_dp) ? result_dp_multiplier :
                          (opCode == 2'b11 && sp_dp) ? result_dp_divider :
                          64'b0;
    
    assign overflow = (opCode == 2'b00 && !sp_dp) ? overflow_underflow_flag_adder_sp :
                        (opCode == 2'b01 && !sp_dp) ? overflow_underflow_flag_subtractor_sp :
                        (opCode == 2'b10 && !sp_dp) ? overflow_flag_multiplier_sp :
                        (opCode == 2'b11 && !sp_dp) ? overflow_flag_divider_sp :
                        (opCode == 2'b00 && sp_dp) ? overflow_underflow_flag_adder_dp :
                        (opCode == 2'b01 && sp_dp) ? overflow_underflow_flag_subtractor_dp :
                        (opCode == 2'b10 && sp_dp) ? overflow_flag_multiplier_dp :
                        (opCode == 2'b11 && sp_dp) ? overflow_flag_divider_dp :
                        1'b0;
    
    assign underflow = (opCode == 2'b00 && !sp_dp) ? overflow_underflow_flag_adder_sp :
                        (opCode == 2'b01 && !sp_dp) ? overflow_underflow_flag_subtractor_sp :
                        (opCode == 2'b10 && !sp_dp) ? underflow_flag_multiplier_sp :
                        (opCode == 2'b11 && !sp_dp) ? underflow_flag_divider_sp :
                        (opCode == 2'b00 && sp_dp) ? overflow_underflow_flag_adder_dp :
                        (opCode == 2'b01 && sp_dp) ? overflow_underflow_flag_subtractor_dp :
                        (opCode == 2'b10 && sp_dp) ? underflow_flag_multiplier_dp :
                        (opCode == 2'b11 && sp_dp) ? underflow_flag_divider_dp :
                        1'b0;
    

    
endmodule