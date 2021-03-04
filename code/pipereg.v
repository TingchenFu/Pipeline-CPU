`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 22:15:46
// Design Name: 
// Module Name: pipereg
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


module IFID(CLK,IFIDFrozen,Inst,Add4,Add8,IDop,IDfunc,IDrs,IDrt,IDrd,IDshamt,IDimm16,IDimm26,IDAdd4,IDAdd8);
input CLK;
input IFIDFrozen;
input [31:0]Inst;
input [31:0]Add4;
input [31:0]Add8;
output reg[5:0] IDop;
output reg[5:0] IDfunc;
output reg[4:0] IDrs,IDrt,IDrd,IDshamt;
output reg[15:0] IDimm16;
output reg[25:0] IDimm26;
output reg[31:0] IDAdd4;
output reg[31:0] IDAdd8;
initial begin
    IDop=0;
    IDfunc=0;
    IDrs=0;
    IDrt=0;
    IDrd=0;
    IDshamt=0;
    IDimm16=0;
    IDimm26=0;
    IDAdd4=0;
    IDAdd8=0;
end
always @ (posedge CLK)
begin
    //#9;
    if(!IFIDFrozen)
    begin
        IDop=Inst[31:26];
        IDfunc=Inst[5:0];
        IDshamt=Inst[10:6];
        IDrd=Inst[15:11];
        IDrt=Inst[20:16];
        IDrs=Inst[25:21];
        IDimm16=Inst[15:0];
        IDimm26=Inst[25:00];
        IDAdd4=Add4;
        IDAdd8=Add8;
    end
end
endmodule

module IDEX(CLK,IDEXClear,IDrs,IDrt,IDrd,IDshamt,IDWriteReg,IDAdd4,IDAdd8,IDRegWrite,IDRegWriteSrc,IDMemWrite,IDType,IDALUSrc,IDALUOperation,IDALUMD,IDCMPOperation,IDWord,IDReadSign,IDsignext,IDzeroext,IDGPRReadData1,IDGPRReadData2,
EXrs,EXrt,EXrd,EXshamt,EXWriteReg,EXAdd4,EXAdd8,EXRegWrite,EXRegWrteSrc,EXMemWrite,EXType,EXALUSrc,EXALUOperation,EXALUMD,EXCMPOperation,EXWord,EXReadSign,EXsignext,EXzeroext,EXGPRReadData1,EXGPRReadData2);
input CLK;
input IDEXClear;
input [4:0]IDrs,IDrt,IDrd,IDshamt,IDWriteReg;
input [4:0] IDALUOperation;
input [31:0]IDAdd4,IDAdd8;
input IDRegWrite,IDMemWrite,IDALUSrc,IDALUMD,IDReadSign;
input [1:0]IDRegWriteSrc,IDWord;
input [2:0]IDType,IDCMPOperation;
input [31:0] IDsignext,IDzeroext,IDGPRReadData1,IDGPRReadData2;
output reg [4:0]EXrs,EXrt,EXrd,EXshamt,EXWriteReg;
output reg [4:0]EXALUOperation;
output reg [31:0]EXAdd4,EXAdd8;
output reg EXRegWrite,EXMemWrite,EXALUSrc,EXALUMD,EXReadSign;
output reg [1:0] EXRegWrteSrc,EXWord;
output reg [2:0] EXType,EXCMPOperation;
output reg [31:0] EXsignext,EXzeroext,EXGPRReadData1,EXGPRReadData2;

initial begin
    EXrs=0;
    EXrt=0;
    EXrd=0;
    EXshamt=0;
    EXWriteReg=0;
    EXAdd4=0;
    EXAdd8=0;
    EXRegWrite=0;
    EXRegWrteSrc=0;
    EXMemWrite=0;
    EXType=0;
    EXALUSrc=0;
    EXALUOperation=0;
    EXALUMD=0;
    EXCMPOperation=0;
    EXWord=0;
    EXReadSign=0;
    EXsignext=0;
    EXzeroext=0;
    EXGPRReadData1=0;
    EXGPRReadData2=0;
end

always @ (posedge CLK)
begin
    //#6;
    if(IDEXClear)
    begin
    EXrs=0;
    EXrt=0;
    EXrd=0;
    EXshamt=0;
    EXWriteReg=0;
    EXAdd4=0;
    EXAdd8=0;
    EXRegWrite=0;
    EXRegWrteSrc=0;
    EXMemWrite=0;
    EXType=0;
    EXALUSrc=0;
    EXALUOperation=0;
    EXALUMD=0;
    EXCMPOperation=0;
    EXWord=0;
    EXReadSign=0;
    EXsignext=0;
    EXzeroext=0;
    EXGPRReadData1=0;
    EXGPRReadData2=0;
    end
    else
    begin
    EXrs=IDrs;
    EXrt=IDrt;
    EXrd=IDrd;
    EXshamt=IDshamt;
    EXWriteReg=IDWriteReg;
    EXAdd4=IDAdd4;
    EXAdd8=IDAdd8;
    EXRegWrite=IDRegWrite;
    EXRegWrteSrc=IDRegWriteSrc;
    EXMemWrite=IDMemWrite;
    EXType=IDType;
    EXALUSrc=IDALUSrc;
    EXALUOperation=IDALUOperation;
    EXALUMD=IDALUMD;
    EXCMPOperation=IDCMPOperation;
    EXWord=IDWord;
    EXReadSign=IDReadSign;
    EXsignext=IDsignext;
    EXzeroext=IDzeroext;
    EXGPRReadData1=IDGPRReadData1;
    EXGPRReadData2=IDGPRReadData2;
    end
end
endmodule

module EXMEM(CLK,EXALUResult,EXDMWriteData,EXrs,EXrt,EXrd,EXWriteReg,EXAdd4,EXAdd8,EXRegWrite,EXRegWriteSrc,EXMemWrite,EXWord,EXReadSign,EXType,
    MEMALUResult,MEMDMWriteData,MEMrs,MEMrt,MEMrd,MEMWriteReg,MEMAdd4,MEMAdd8,MEMRegWrite,MEMRegWriteSrc,MEMMemWrite,MEMWord,MEMReadSign,MEMType);
input CLK;
input [31:0] EXALUResult,EXDMWriteData,EXAdd4,EXAdd8;
input [4:0] EXWriteReg,EXrs,EXrt,EXrd;
input EXRegWrite,EXMemWrite,EXReadSign;
input [1:0] EXRegWriteSrc,EXWord;
input [2:0] EXType;
output reg [31:0] MEMALUResult,MEMDMWriteData,MEMAdd4,MEMAdd8;
output reg [4:0] MEMWriteReg,MEMrs,MEMrt,MEMrd;
output reg MEMRegWrite,MEMMemWrite,MEMReadSign;
output reg [1:0] MEMRegWriteSrc,MEMWord;
output reg [2:0] MEMType;
initial begin
    MEMALUResult=0;
    MEMDMWriteData=0;
    MEMAdd4=0;
    MEMAdd8=0;
    MEMWriteReg=0;
    MEMrs=0;
    MEMrt=0;
    MEMrd=0;
    MEMRegWrite=0;
    MEMMemWrite=0;
    MEMRegWriteSrc=0;
    MEMWord=0;
    MEMReadSign=0;
    MEMType=0;
end

always @ ( posedge CLK)
begin
    //#3;
    MEMALUResult=EXALUResult;
    MEMDMWriteData=EXDMWriteData;
    MEMAdd4=EXAdd4;
    MEMAdd8=EXAdd8;
    MEMWriteReg=EXWriteReg;
    MEMrs=EXrs;
    MEMrt=EXrt;
    MEMrd=EXrd;
    MEMRegWrite=EXRegWrite;
    MEMMemWrite=EXMemWrite;
    MEMRegWriteSrc=EXRegWriteSrc;
    MEMWord=EXWord;
    MEMReadSign=EXReadSign;
    MEMType=EXType;
end

endmodule

module MEMWB(CLK,MEMrs,MEMrt,MEMrd,MEMWriteReg,MEMALUResult,MEMDMReadData,MEMRegWrite,MEMRegWriteSrc,MEMWriteBit,MEMReadSign,MEMAdd4,MEMAdd8,MEMType,
    WBrs,WBrt,WBrd,WBWriteReg,WBALUResult,WBDMReadData,WBRegWrite,WBRegWriteSrc,WBReadBit,WBReadSign,WBAdd4,WBAdd8,WBType);
input CLK;
input [4:0] MEMrs,MEMrt,MEMrd,MEMWriteReg;
input [31:0] MEMALUResult,MEMDMReadData;
input MEMRegWrite,MEMReadSign;
input [1:0] MEMRegWriteSrc;
input [31:0] MEMAdd4,MEMAdd8;
input [2:0] MEMType;
input [3:0] MEMWriteBit;
output reg[4:0] WBrs,WBrt,WBrd,WBWriteReg;
output reg[31:0] WBALUResult,WBDMReadData;
output reg WBRegWrite,WBReadSign;
output reg [1:0] WBRegWriteSrc;
output reg[31:0] WBAdd4,WBAdd8;
output reg[2:0] WBType;
output reg[3:0] WBReadBit;
initial begin
    WBrs=0;
    WBrt=0;
    WBrd=0;
    WBWriteReg=0;
    WBALUResult=0;
    WBDMReadData=0;
    WBRegWrite=0;
    WBRegWriteSrc=0;
    WBAdd4=0;
    WBAdd8=0;
    WBReadBit=0;
    WBReadSign=0;
    WBType=0;
end

always @(posedge CLK)
begin
    WBrs=MEMrs;
    WBrt=MEMrt;
    WBrd=MEMrd;
    WBWriteReg=MEMWriteReg;
    WBALUResult=MEMALUResult;
    WBDMReadData=MEMDMReadData;
    WBRegWrite=MEMRegWrite;
    WBRegWriteSrc=MEMRegWriteSrc;
    WBAdd4=MEMAdd4;
    WBAdd8=MEMAdd8;
    WBReadBit=MEMWriteBit;
    WBReadSign=MEMReadSign;
    WBType=MEMType;
end

endmodule
