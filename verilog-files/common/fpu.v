module fpu(
    input clk,
    input sp_dp,    // 0 = single precision, 1 = double precision
    input [1:0] opCode, // 00 = add, 01 = subtract, 10 = multiply, 11 = divide
    input [31:0] a_sp,
    input [31:0] b_sp,
    input [63:0] a_dp,
    input [63:0] b_dp,
    output wire [31:0] result_sp,
    output wire [63:0] result_dp,
    output wire overflow,
    output wire underflow,
    output wire ready
    );


    // Single precision
    wire overflow_sp;
    wire underflow_sp;
    wire ready_sp;
    wire [31:0] result_sp_temp;
    
    fpu_sp fpu_sp_inst (
        .clk(clk),
        .OpCode(opCode),
        .A(a_sp),
        .B(b_sp),
        .Result(result_sp_temp),
        .Ready(ready_sp),
        .Overflow_out(overflow_sp),
        .Underflow_out(underflow_sp)
    );

    // Double precision
    wire overflow_dp;
    wire underflow_dp;
    wire ready_dp;
    wire [63:0] result_dp_temp;

    fpu_dp fpu_dp_inst (
        .clk(clk),
        .OpCode(opCode),
        .A(a_dp),
        .B(b_dp),
        .Result(result_dp_temp),
        .Ready(ready_dp),
        .Overflow_out(overflow_dp),
        .Underflow_out(underflow_dp)
    );

    // Select single or double precision
    assign overflow = sp_dp ? overflow_dp : overflow_sp;
    assign underflow = sp_dp ? underflow_dp : underflow_sp;
    assign ready = sp_dp ? ready_dp : ready_sp;

    assign result_sp = sp_dp ? 32'b0 : result_sp_temp;
    assign result_dp = sp_dp ? result_dp_temp : 64'b0;

endmodule