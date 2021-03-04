`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 21:11:46
// Design Name: 
// Module Name: gpr
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


module GPR(ReadReg1,ReadReg2,WriteReg,WriteData,RegWrite,CLK,ReadData1,ReadData2);
input [4:0] ReadReg1;
input [4:0] ReadReg2;
input [4:0] WriteReg;
input [31:0] WriteData;
output [31:0] ReadData1;
output [31:0] ReadData2;
input RegWrite;//flags
input CLK;

reg [31:0] RegFile[31:0];
integer i;
initial begin
    for (i=0;i<32;i=i+1)
        RegFile[i]=0;
end

assign ReadData1=RegFile[ReadReg1];
assign ReadData2=RegFile[ReadReg2];

always @ (negedge CLK)
begin
    if(RegWrite)
    begin
        RegFile[WriteReg]=WriteData;
        //$display("%h,%h",WriteReg,WriteData);
    end
    
end
endmodule
