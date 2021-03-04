`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 16:58:10
// Design Name: 
// Module Name: im_4k
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


module im_4k(addr,dout);
input [11:2] addr;
output[31:0] dout;
reg [31:0] im[1023:0];
initial begin
    $readmemh("D:\\asmcode\\test42.txt",im);
end
integer i;
initial begin
        $display("start simulation");
        for (i=0;i<4;i=i+1)
            $display("%h %h", i,im[i]);
end
assign dout=im[addr];
endmodule
