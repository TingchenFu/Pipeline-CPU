`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 20:30:02
// Design Name: 
// Module Name: dm
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


module dm_4k(addr,din,we,WriteBit,clk,dout);
input [11:2] addr;
input [31:0] din;
input we;
input [3:0]WriteBit;
input clk;
output [31:0] dout;
reg [31:0] dm[1023:0];
integer i;
integer j;

initial begin
for(i=0;i<1024;i=i+1)
    dm[i]=0;
end

assign dout=dm[addr];

always@(posedge clk)begin
    if(we)
    begin
        j=0;
        if(WriteBit[0])
        begin
            dm[addr][7:0]=din[j+ :8];
            j=j+8;
        end
        if(WriteBit[1])
        begin
            dm[addr][15:8]=din[j+ :8];
            j=j+8;
        end
        if(WriteBit[2])
        begin
            dm[addr][23:16]=din[j+ :8];
            j=j+8;            
        end
        if(WriteBit[3])
            dm[addr][31:24]=din[j+ :8];
    end
end;
endmodule
