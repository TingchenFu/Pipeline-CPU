`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/05 11:27:36
// Design Name: 
// Module Name: mips
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


module MIPS(CLK,Reset);
input CLK;
input Reset;
integer count;

wire [31:0] PC,PCAdd4,PCAdd8,NextPC;
wire [31:0] BranchResult,JumpResult;
wire PCFrozen,IFIDFrozen,IDEXClear,EXMDBusy;
wire [31:0] Inst;
wire [5:0] IDop;
wire [5:0] IDfunc;
wire [4:0] IDrs,IDrt,IDrd,IDWriteReg,IDshamt,EXrs,EXrt,EXrd,EXWriteReg,EXshamt,MEMrs,MEMrt,MEMrd,MEMWriteReg,WBrs,WBrt,WBrd,WBWriteReg;
wire [15:0] IDimm16;
wire [25:0] IDimm26;
wire [31:0] IDAdd4,IDAdd8,EXAdd4,EXAdd8,MEMAdd4,MEMAdd8,WBAdd4,WBAdd8;
wire [1:0] IDPCSrc,IDRegWriteSrc,IDRegDst,IDWord,EXRegWriteSrc,EXWord,MEMRegWriteSrc,MEMWord,WBRegWriteSrc;
wire IDRegWrite,IDMemWrite,IDALUSrc,IDALUMD,IDReadSign,EXRegWrite,EXMemWrite,EXALUSrc,EXALUMD,EXReadSign,MEMRegWrite,MEMMemWrite,MEMReadSign,WBRegWrite,WBReadSign;
wire [2:0] IDType,IDCMPOperation,EXCMPOperation,EXType,MEMType,WBType;
wire [3:0] MEMWriteBit,WBReadBit;
wire [4:0] IDALUOperation,EXALUOperation;
wire [31:0]GPRReadData1,GPRReadData2;
wire [31:0] IDGPRReadData1,IDGPRReadData2;
wire [31:0] IDsignimm32,IDunsignimm32,shiftleft2,EXsignimm32,EXunsignimm32,EXimm32,EXGPRReadData1,EXGPRReadData2,MEMGPRReadData2;
wire CMPResult;
wire [31:0] Operand1,Operand2,EXALUResult,EXMDResult,EXComputeResult,MEMComputeResult,WBComputeResult;
wire [31:0] EXDMWriteData,MEMDMWriteData,MEMDMReadData,WBDMReadData,WBDMReadDataCooked;
wire [31:0] WBRegWriteData;
wire [1:0] ForwardEX1,ForwardEX2;
wire [1:0] ForwardID1,ForwardID2;
wire ForwardMEM;

PC pc(NextPC,Reset,CLK,PCFrozen,PC);
PCAdd4 pcadd4(PC,PCAdd4,PCAdd8);
MUX4x32 mux4x32(PCAdd4,BranchResult,JumpResult,IDGPRReadData1,IDPCSrc,NextPC);
im_4k im(PC[11:2],Inst);
IFID ifid(CLK,IFIDFrozen,Inst,PCAdd4,PCAdd8,IDop,IDfunc,IDrs,IDrt,IDrd,IDshamt,IDimm16,IDimm26,IDAdd4,IDAdd8);
Control control(IDop,IDfunc,IDrt,IDPCSrc,IDRegWriteSrc,IDRegWrite,IDMemWrite,IDRegDst,IDALUSrc,IDALUOperation,IDALUMD,IDCMPOperation,IDWord,IDReadSign,IDType);
GPR gpr(IDrs,IDrt,WBWriteReg,WBRegWriteData,WBRegWrite,CLK,GPRReadData1,GPRReadData2); 
MUX3x32 mux3x32_4(GPRReadData1,MEMComputeResult,WBRegWriteData,ForwardID1,IDGPRReadData1);
MUX3x32 mux3x32_5(GPRReadData2,MEMComputeResult,WBRegWriteData,ForwardID2,IDGPRReadData2);
//MUX2x32 mux2x32_1(GPRReadData1,MEMComputeResult,ForwardID1,IDGPRReadData1); 
//MUX2x32 mux2x32_2(GPRReadData2,MEMComputeResult,ForwardID2,IDGPRReadData2); 
Extend extend(IDimm16,IDsignimm32,IDunsignimm32);
LeftShift2 leftshift2(IDsignimm32,shiftleft2);
CMP cmp(IDGPRReadData1,IDGPRReadData2,IDCMPOperation,CMPResult);
PCBranch pcbranch(shiftleft2,CMPResult,IDAdd4,IDAdd8,BranchResult);
PCJump pcjump(IDimm26,IDAdd4,JumpResult);
MUX3x5 mux3x5(IDrt,IDrd,5'b11111,IDRegDst,IDWriteReg);
IDEX idex(CLK,IDEXClear,IDrs,IDrt,IDrd,IDshamt,IDWriteReg,IDAdd4,IDAdd8,IDRegWrite,IDRegWriteSrc,IDMemWrite,IDType,IDALUSrc,IDALUOperation,IDALUMD,IDCMPOperation,IDWord,IDReadSign,IDsignimm32,IDunsignimm32,IDGPRReadData1,IDGPRReadData2,//?
    EXrs,EXrt,EXrd,EXshamt,EXWriteReg,EXAdd4,EXAdd8,EXRegWrite,EXRegWriteSrc,EXMemWrite,EXType,EXALUSrc,EXALUOperation,EXALUMD,EXCMPOperation,EXWord,EXReadSign,EXsignimm32,EXunsignimm32,EXGPRReadData1,EXGPRReadData2);
MUX3x32 mux3x32_1(EXGPRReadData1,MEMComputeResult,WBRegWriteData,ForwardEX1,Operand1); 
MUX3x32 mux3x32_2(EXGPRReadData2,MEMComputeResult,WBRegWriteData,ForwardEX2,EXDMWriteData); 
MUX2x32 mux2x32_3(EXunsignimm32,EXsignimm32,EXReadSign,EXimm32);
MUX2x32 mux2x32_4(EXimm32,EXDMWriteData,EXALUSrc,Operand2); 
ALU alu(Operand1,Operand2,EXALUOperation,EXshamt,EXALUResult);
MD md(CLK,Operand1,Operand2,EXALUOperation,EXMDResult,EXMDBusy);
MUX2x32 mux2x32_5(EXALUResult,EXMDResult,EXALUMD,EXComputeResult);
EXMEM exmem(CLK,EXComputeResult,EXDMWriteData,EXrs,EXrt,EXrd,EXWriteReg,EXAdd4,EXAdd8,EXRegWrite,EXRegWriteSrc,EXMemWrite,EXWord,EXReadSign,EXType,
    MEMComputeResult,MEMGPRReadData2,MEMrs,MEMrt,MEMrd,MEMWriteReg,MEMAdd4,MEMAdd8,MEMRegWrite,MEMRegWriteSrc,MEMMemWrite,MEMWord,MEMReadSign,MEMType);
MUX2x32 mux2x32_6(MEMGPRReadData2,WBRegWriteData,ForwardMEM,MEMDMWriteData);
BE be(MEMComputeResult[1:0],MEMWord,MEMWriteBit);
dm_4k dm(MEMComputeResult[11:2],MEMDMWriteData,MEMMemWrite,MEMWriteBit,CLK,MEMDMReadData);
MEMWB memwb(CLK,MEMrs,MEMrt,MEMrd,MEMWriteReg,MEMComputeResult,MEMDMReadData,MEMRegWrite,MEMRegWriteSrc,MEMWriteBit,MEMReadSign,MEMAdd4,MEMAdd8,MEMType,
    WBrs,WBrt,WBrd,WBWriteReg,WBComputeResult,WBDMReadData,WBRegWrite,WBRegWriteSrc,WBReadBit,WBReadSign,WBAdd4,WBAdd8,WBType);
Preprocess preprocess(WBDMReadData,WBReadBit,WBReadSign,WBDMReadDataCooked);
MUX3x32 mux3x32_3(WBComputeResult,WBDMReadDataCooked,WBAdd8,WBRegWriteSrc,WBRegWriteData);
Hazard hazard(CLK,EXrs,EXrt,EXType,EXRegWrite,EXWriteReg,IDType,IDrt,IDrs,MEMWriteReg,MEMRegWrite,MEMType,MEMrt,WBWriteReg,WBRegWrite,EXMDBusy,
    ForwardID1,ForwardID2,ForwardEX1,ForwardEX2,ForwardMEM,PCFrozen,IFIDFrozen,IDEXClear);


initial begin
    count=0;
end
always @(negedge CLK)
    begin
        #5;
        count=count+1;
        $display("PC:%h,count:%h",PC,count);
    end
endmodule
