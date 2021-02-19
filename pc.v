`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/21 20:20:08
// Design Name:
// Module Name: pc
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


module PC(
         input [31:0] Result,
         input Reset,
         input CLK,
         input PCFrozen,
         output reg [31:0] Next
       );
initial
  Next=8'h00003000;
always @(posedge CLK or negedge Reset)
  begin
    #12;
    if(!PCFrozen)
      begin
        if (!Reset)
          begin
            Next=8'h00003000;
            $display("reset: %h",Next);
          end
        else
          begin
            Next=Result;
          end
      end
  end
endmodule

  module PCAdd4(OldPC,Add4,Add8);
input [31:0] OldPC;
output [31:0] Add4;
output [31:0] Add8;
assign Add4=OldPC+4;
assign Add8=OldPC+8;
endmodule

  module PCBranch(LeftShift2,Qualified,Add4,Add8,Result);
input [31:0] LeftShift2;
input [31:0] Add4;
input [31:0] Add8;
input Qualified;
output [31:0] Result;
assign Result=Qualified? LeftShift2+Add4:Add4;
endmodule

  module PCJump(Addr26,Add4,Result);
input [25:0] Addr26;
input [31:0] Add4;
output[31:0] Result;
wire [25:0] ShiftAddr26;
wire  [27:0]temp;
assign temp={Addr26,2'b00};
assign Result={Add4[31:28],temp};
endmodule

