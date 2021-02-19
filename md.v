`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 20:30:07
// Design Name: 
// Module Name: md
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


module MD(CLK,MDOperand1,MDOperand2,MDOperation,MDResult,MDBusy);
input CLK;
input[31:0] MDOperand1,MDOperand2;
input[4:0] MDOperation;
output reg[31:0] MDResult;
output reg MDBusy;

reg[31:0] high,low;
integer count;
wire [63:0] SignProd,UnsignProd;
wire [31:0] SignQuot,SignRem;
wire [31:0] UnsignQuot,UnsignRem;
wire start;
assign start=(MDOperation<= 5'b01000 && MDOperation>=5'b00101)?1:0;

initial begin
    high=0;
    low=0;
    count=0;
    MDBusy=0;
end

always@(posedge CLK)
begin
    if(start && !MDBusy)
    begin
        MDBusy=1;
        if(MDOperation==5'b00101 || MDOperation==5'b00110)
        begin
            count=5;
        end
        if(MDOperation==5'b00111 || MDOperation==5'b01000)
        begin
            count=10;
        end
    end
    if(count)
        count=count-1;
    if(!count)
        MDBusy=0;
end

assign SignProd=$signed(MDOperand1) * $signed(MDOperand2);
assign UnsignProd=MDOperand1*MDOperand2;
assign SignQuot=$signed(MDOperand1)/$signed(MDOperand2);
assign SignRem=$signed(MDOperand1)% $signed(MDOperand2);
assign UnsignQuot=MDOperand1 / MDOperand2;
assign UnsignRem=MDOperand1 % MDOperand2;

always@(CLK or MDOperand1 or MDOperand2 or MDOperation)
begin
    case(MDOperation)
    5'b00101:begin
        high=UnsignProd[63:32];
        low=UnsignProd[31:0];
    end
    5'b00110:begin
        high=SignProd[63:32];
        low=SignProd[31:0];
    end
    5'b00111:begin
        high=UnsignRem;
        low=UnsignQuot;
    end
    5'b01000:begin
        high=SignRem;
        low=SignQuot;
    end
    5'b01001:begin
        MDResult=high;
    end
    5'b01010:begin
        MDResult=low;
    end
    5'b01011:begin
        high=MDOperand1;
    end
    5'b01100:begin
        low=MDOperand1;
    end
    endcase
end

endmodule