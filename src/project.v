/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module custom_logic (
    input [7:0] A,  // 8-bit input A
    input [7:0] B,  // 8-bit input B
    output reg [7:0] C  // 8-bit output C
);

    // Internal signal for XOR result
    wire [7:0] xor_result;
    assign xor_result = A ^ B;  // Bitwise XOR of A and B

    // Conditional inversion based on A[7]
    always @(*) begin
        if (A[7] == 1'b0) begin
            C = xor_result;  // Output is XOR result
        end else begin
            C = ~xor_result;  // Output is inverted XOR result
        end
    end

endmodule
