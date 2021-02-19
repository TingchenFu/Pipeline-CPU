`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 20:09:03
// Design Name: 
// Module Name: preprocess
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


module Preprocess(raw,ReadBit,ReadSign,cooked);
input [31:0] raw;
input [3:0] ReadBit;
input ReadSign;
output reg[31:0] cooked;
integer i,j;
reg SignBit;
always @ (*)
begin
    i=0;
    if(ReadBit[0])
    begin
        cooked[i+:8]=raw[7:0];
        SignBit=cooked[i+7];
        i=i+8;
    end
    if(ReadBit[1])
    begin
        cooked[i+:8]=raw[15:8];
        SignBit=cooked[i+7];
        i=i+8;
    end
    if(ReadBit[2])
    begin
        cooked[i+:8]=raw[23:16];
        SignBit=cooked[i+7];
        i=i+8;
    end
    if(ReadBit[3])
    begin
        cooked[i+:8]=raw[31:24];
        SignBit=cooked[i+7];
        i=i+8;
    end
    for(j=i;j<32;j=j+1)
    begin
        if(ReadSign)
            cooked[j]=SignBit;
        else
            cooked[j]=0;
    end
end
endmodule
