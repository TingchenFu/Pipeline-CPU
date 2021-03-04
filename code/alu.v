`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 19:08:32
// Design Name: 
// Module Name: ALU
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

module ALU(Operand1,Operand2,ALUOperation,Shamt,Result);
input [31:0] Operand1;
input [31:0] Operand2;
input [4:0] ALUOperation;
input [4:0] Shamt;
output reg[31:0] Result;

begin initial
    Result=0;
end

always @ (Operand1 or Operand2 or ALUOperation or Shamt)
begin
    case(ALUOperation)
        5'b00000:Result=Operand2<<16;
        5'b00001:Result=Operand1+Operand2;
        5'b00010:Result=$signed(Operand1)+$signed(Operand2);
        5'b00011:Result=Operand1-Operand2;
        5'b00100:Result=$signed(Operand1)-$signed(Operand2);
        5'b01101:Result=Operand1 & Operand2;
        5'b01110:Result=Operand1 | Operand2;
        5'b01111:Result=Operand1 ^ Operand2;
        5'b10000:Result=~(Operand1 | Operand2);
        5'b10001:Result=Operand2 << Shamt;
        5'b10010:Result=$signed(Operand2)>>>Shamt;
        5'b10011:Result=Operand2>>Shamt;
        5'b10100:Result=Operand2<<Operand1[4:0];
        5'b10101:Result=$signed(Operand2)>>>Operand1[4:0];
        5'b10110:Result=Operand2>>Operand1[4:0];
        5'b10111:Result=($signed(Operand1)<$signed(Operand2));
        5'b11000:Result=(Operand1<Operand2);

    endcase
    ///$display("alu :%h op %h = %h\n",Operand1,Operand2,Result);
end
endmodule
