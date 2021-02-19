`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 19:22:56
// Design Name: 
// Module Name: mux
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

module MUX3x32(x0,x1,x2,sig,y);
input [31:0] x0;
input [31:0] x1;
input [31:0] x2;
input [1:0] sig;
output [31:0] y;

function  [31:0] select;
    input [31:0] x0,x1,x2;
    input [1:0]sig;
    case(sig)
        2'b00: select=x0;
        2'b01: select=x1;
        2'b10: select=x2;
    endcase
endfunction

assign y=select(x0,x1,x2,sig);
endmodule

module MUX3x5(x0,x1,x2,sig,y);
input [4:0] x0,x1,x2;
input [1:0] sig;
output [4:0] y;

function  [4:0] select;
    input [4:0] x0,x1,x2;
    input [1:0] sig;
    case(sig)
        2'b00:select=x0;//rt
        2'b01:select=x1;//rd
        2'b10:select=x2;
        2'b11:select=(x1==0)?x2:x1;
    endcase
endfunction

assign y=select(x0,x1,x2,sig);
endmodule

module MUX2x32(x0,x1,sig,y);
input [31:0]x0,x1;
input sig;
output [31:0] y;
assign y=sig?x1:x0;
endmodule

module MUX4x32(x0,x1,x2,x3,sig,y);
input [31:0] x0,x1,x2,x3;
input [1:0]sig;
output reg[31:0] y;
always @ (x0 or x1 or x2 or x3 or sig)
begin
    case(sig)
    2'b00:y=x0;
    2'b01:y=x1;
    2'b10:y=x2;
    2'b11:y=x3;
    endcase
    //$display("select %h",y);
end
endmodule


