`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 21:43:16
// Design Name: 
// Module Name: extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Extend(imm16,signimm32,unsignimm32);
    input [15:0] imm16;
    output[31:0] signimm32;
    output[31:0] unsignimm32;
    wire [15:0] zero16;
    wire [31:0] temp1;
    wire [31:0] temp2;
    parameter z = 16'b0;
    wire [15:0] e = {16{imm16[15]}};
    assign  unsignimm32 = {z, imm16};
    assign  signimm32 = {e, imm16};
endmodule
