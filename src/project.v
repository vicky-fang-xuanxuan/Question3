/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

module tt_um_example (
    input  wire [7:0] ui_in,    // A input
    output wire [7:0] uo_out,   // C output
    input  wire [7:0] uio_in,   // B input
    output wire [7:0] uio_out,  // IO Output (unused, set to 0)
    output wire [7:0] uio_oe,   // IO Enable (unused, set to 0)
    input  wire       ena,      // Enable (unused)
    input  wire       clk,      // Clock (unused)
    input  wire       rst_n     // Reset (unused)
);

  // 实现 2:1 复用器功能
  mux_two_one first  (ui_in[0], uio_in[0], ui_in[7], uo_out[0]);
  mux_two_one second (ui_in[1], uio_in[1], ui_in[7], uo_out[1]);
  mux_two_one third  (ui_in[2], uio_in[2], ui_in[7], uo_out[2]);
  mux_two_one fourth (ui_in[3], uio_in[3], ui_in[7], uo_out[3]);

  mux_two_one fifth  (uo_out[0], uio_in[4], uio_in[7], uo_out[4]);
  mux_two_one sixth  (uo_out[1], uio_in[5], uio_in[7], uo_out[5]);
  mux_two_one seventh(uo_out[2], uio_in[6], uio_in[7], uo_out[6]);
  mux_two_one eighth (uo_out[3], uio_in[7], uio_in[7], uo_out[7]);

  // 未使用的输出设置为 0
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000;

  // 避免未使用信号的编译警告
  wire unused = &{ena, clk, rst_n};

endmodule

// 2:1 复用器模块
module mux_two_one (
    input wire a, 
    input wire b, 
    input wire sel, 
    output wire o
);
    assign o = (~sel & a) | (sel & b);
endmodule
