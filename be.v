`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 19:29:24
// Design Name: 
// Module Name: be
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


module BE(LowAddr,Word,WriteBit);
input [1:0]LowAddr;
input [1:0]Word;
output reg[3:0]WriteBit;
initial begin
    WriteBit=4'b0000;
end
always @(*)
begin
    if(!Word)
    begin
        WriteBit=4'b1111;
    end
    if(Word[0]) //half word
    begin
        if(LowAddr[1])
        begin
            WriteBit=4'b1100;
        end
        else
        begin
            WriteBit=4'b0011;
        end
    end
    if(Word[1])
    begin
        if(LowAddr==2'b00)
            WriteBit=4'b0001;
        if(LowAddr==2'b01)
            WriteBit=4'b0010;
        if(LowAddr==2'b10)
            WriteBit=4'b0100;
        if(LowAddr==2'b11)
            WriteBit=4'b1000;
    end
end

endmodule
