/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module bitwise_majority (
    input  wire [7:0] A,      // First 8-bit input
    input  wire [7:0] B,      // Second 8-bit input
    output wire [7:0] C       // 8-bit Output
);

  assign C = (A & B) | (A ^ B); // Bitwise majority function

endmodule
