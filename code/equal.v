`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 17:48:35
// Design Name: 
// Module Name: equal
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


module Equal(GPRReadData1,GPRReadData2,Result);
input [31:0] GPRReadData1,GPRReadData2;
output Result;
assign Result=(GPRReadData1==GPRReadData2);
endmodule

module CMP(CMPOperand1,CMPOperand2,CMPOperation,result);
input [31:0] CMPOperand1,CMPOperand2;
input [2:0]CMPOperation;
output reg result;
initial begin
    result=0;
end
always@(CMPOperand1 or CMPOperand2 or CMPOperation)
begin
    case(CMPOperation)
    3'b000:result=(CMPOperand1==CMPOperand2);
    3'b001:result=(CMPOperand1!=CMPOperand2);
    3'b010:result=($signed(CMPOperand1)>0);
    3'b011:result=($signed(CMPOperand1)>=0);
    4'b100:result=($signed(CMPOperand1)<0);
    4'b101:result=($signed(CMPOperand1)<=0);
    endcase
end
endmodule
