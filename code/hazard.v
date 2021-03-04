`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/05 09:44:54
// Design Name: 
// Module Name: hazard
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


module Hazard(CLK,EXrs,EXrt,EXType,EXRegWrite,EXWriteReg,IDType,IDrt,IDrs,MEMWriteReg,MEMRegWrite,MEMType,MEMrt,WBWriteReg,WBRegWrite,MDBusy,
    ForwardID1,ForwardID2,ForwardEX1,ForwardEX2,ForwardMEM,PCFrozen,IFIDFrozen,IDEXClear);
    input CLK;
    input [4:0] IDrs,IDrt,EXrs,EXrt,EXWriteReg,MEMrt,MEMWriteReg,WBWriteReg;
    input [2:0] IDType,EXType,MEMType;
    input EXRegWrite,MEMRegWrite,WBRegWrite,MDBusy;
    output reg[1:0] ForwardEX1,ForwardEX2,ForwardID1,ForwardID2;
    output reg ForwardMEM;
    output reg PCFrozen,IFIDFrozen,IDEXClear;

    integer count;
    initial begin
        PCFrozen=0;
        IFIDFrozen=0;
        IDEXClear=0;
        ForwardEX1=0;
        ForwardEX2=0;
        ForwardID1=0;
        ForwardID2=0;
        ForwardMEM=0;
        count=0;
    end
    always @(*)
    begin
        PCFrozen=0;
        IFIDFrozen=0;
        IDEXClear=0;
        ForwardEX1=0;
        ForwardEX2=0;
        ForwardID1=0;
        ForwardID2=0;
        ForwardMEM=0;
        // type1
        if(EXrs==MEMWriteReg && MEMWriteReg && MEMRegWrite)
            ForwardEX1=2'b01;
        else if(EXrs==WBWriteReg &&WBWriteReg && WBRegWrite)
            ForwardEX1=2'b10;
        if(EXrt==MEMWriteReg && MEMWriteReg && MEMRegWrite)
            ForwardEX2=2'b01;
        else if(EXrt==WBWriteReg && WBWriteReg && WBRegWrite)
            ForwardEX2=2'b10;
        
        //type2       lw                 R                ori                   lw             sw              jr
        if(EXType==3'b001 && (IDType==3'b000 || IDType==3'b000 || IDType==3'b001 || IDType==3'b010 || IDType==3'b100))
        begin
            if(IDrt==EXrt && IDType==3'b000)//R
            begin
                PCFrozen=1;
                IFIDFrozen=1;
                IDEXClear=1;
                $display("type2 stall");
            end
            if(IDrs==EXrt)
            begin
                PCFrozen=1;
                IFIDFrozen=1;
                IDEXClear=1;
                $display("type2 stall");
            end
        end

        //type3 branch
        if(IDType==3'b111 && (EXWriteReg==IDrs || EXWriteReg ==IDrt) && EXWriteReg && EXRegWrite)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type3 stall1");
        end//                            lw
        if(IDType==3'b111 && MEMType==3'b001 && (IDrs==MEMrt || IDrt==MEMrt))
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type3 stall2");
        end
        else if(IDType==3'b111 && (MEMWriteReg==IDrs || MEMWriteReg ==IDrt)&& MEMWriteReg && MEMRegWrite)
        begin
            if(MEMWriteReg==IDrs)
                ForwardID1=2'b01;
            if(MEMWriteReg ==IDrt)
                ForwardID2=2'b01;
        end
        if(IDType==3'b111 && (WBWriteReg==IDrs || WBWriteReg==IDrt) && WBWriteReg && WBRegWrite)
        begin
            if(WBWriteReg==IDrs)
                ForwardID1=2'b10;
            if(WBWriteReg==IDrt)
                ForwardID2=2'b10;
        end

        /*
        if(IDType==3'b111 && (WBWriteReg==IDrs || WBWriteReg==IDrt) && WBWriteReg && WBRegWrite)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type3 stall3,count=%h",count);
            count=count+1;
        end
        */
        //type4 jr & jalr
        if((IDType==3'b100 || IDType==3'b101) && EXWriteReg==IDrs && EXWriteReg && EXRegWrite)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type4 stall1");
        end
        if((IDType==3'b100 || IDType==3'b101) && MEMWriteReg==IDrs && MEMWriteReg && MEMRegWrite)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type4 stall2");
        end
        if((IDType==3'b100 || IDType==3'b101) && WBWriteReg==IDrs && WBWriteReg && WBRegWrite)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type4 stall3,count=$h",count);
            count=count+1;
        end

        //type5 sw
        if(MEMType==3'b010 && MEMrt==WBWriteReg && WBWriteReg && WBRegWrite)
            ForwardMEM=1;

        //type6 muldiv
        if(MDBusy)
        begin
            PCFrozen=1;
            IFIDFrozen=1;
            IDEXClear=1;
            $display("type6 stall");
        end
    end
endmodule
