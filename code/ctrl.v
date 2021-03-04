`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/04 17:56:37
// Design Name:
// Module Name: ctrl
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


module Control(op,func,rt,PCSrc,RegWriteSrc,RegWrite,MemWrite,RegDst,ALUSrc,ALUOperation,ALUMD,CMPOperation,Word,ReadSign,Instype);
input [5:0] op;
input [5:0] func;
input [4:0] rt;
output [1:0] PCSrc,RegWriteSrc,RegDst,Word;
output [4:0] ALUOperation;
output  ALUMD;
output [2:0] Instype,CMPOperation;
output RegWrite,MemWrite,ALUSrc,ReadSign;

wire I_addu,I_subu,I_add,I_sub;
wire I_mult,I_multu,I_div,I_divu,I_mfhi,I_mflo,I_mthi,I_mtlo;
wire I_sll,I_srl,I_sra,I_sllv,I_srlv,I_srav;
wire I_ori,I_and,I_or,I_xor,I_nor,I_addi,I_addiu,I_andi,I_xori;
wire I_slt,I_slti,I_sltu,I_sltiu;
wire I_beq,I_bne,I_blez,I_bltz,I_bgez,I_bgtz;
wire I_lui;
wire I_jal,I_j,I_jr,I_jalr;
wire I_sb,I_sh,I_lb,I_lbu,I_lh,I_lhu,I_lw,I_sw;

assign I_addu=!op & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & func[0];
assign I_subu=!op & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0];
assign I_ori=~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & op[0];
assign I_lw=op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
assign I_sw=op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
assign I_beq=~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
assign I_lui=~op[5] & ~op[4] & op[3] & op[2] & op[1] & op[0];
assign I_jal=~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
assign I_jr=!op & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];
assign I_j=~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
assign I_sb=op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
assign I_sh=op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0];
assign I_lb=op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
assign I_lbu=op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
assign I_lh=op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0];
assign I_lhu=op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
assign I_add=!op & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
assign I_sub=!op & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
assign I_mult=!op & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];
assign I_multu=!op & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & func[0];
assign I_div=!op & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & ~func[0];
assign I_divu=!op & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & func[0];
assign I_mfhi=!op & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
assign I_mflo=!op & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
assign I_mthi=!op & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & func[0];
assign I_mtlo=!op & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & func[0];
assign I_sll=!op & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
assign I_srl=!op & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
assign I_sra=!op & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0];
assign I_sllv=!op & ~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
assign I_srlv= !op & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
assign I_srav=!op & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
assign I_and=!op & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
assign I_or= !op &func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0];
assign I_xor=!op & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
assign I_nor=!op & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
assign I_addi=~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
assign I_addiu=~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0];
assign I_andi=~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & ~op[0];
assign I_xori=~op[5] & ~op[4] & op[3] & op[2] & op[1] & ~op[0];
assign I_slt=!op & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];
assign I_slti=~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & ~op[0];
assign I_sltu=!op & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & func[0];
assign I_sltiu=~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
assign I_blez=~op[5] & ~op[4] & ~op[3] & op[2] & op[1] & ~op[0];

assign I_bltz=~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & !rt;
assign I_bgez=~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & rt[0];

assign I_bgtz=~op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0];
assign I_bne=~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
assign I_jalr=!op & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & func[0];



assign PCSrc[0]=I_beq | I_jr| I_blez | I_bltz | I_bgez | I_bgtz |I_bne | I_jalr;
assign PCSrc[1]=I_jal | I_jr | I_j | I_jalr;
assign RegWriteSrc[0]=I_lw |I_lb |I_lbu |I_lh |I_lhu;
assign RegWriteSrc[1]=I_jal | I_jalr;
assign RegWrite=~I_sw & ~I_beq & ~I_jr & ~I_j & ~I_sb & ~I_sh & ~I_mult & ~I_multu & ~I_div & ~I_divu & ~I_mthi & ~I_mtlo
        & ~I_blez & ~I_bltz & ~I_bgez & ~I_bgtz & ~I_bne;
assign MemWrite=I_sw | I_sh | I_sb;
assign RegDst[0]=I_addu |I_subu | I_add | I_sub | I_mfhi | I_mflo | I_sll | I_srl | I_sra | I_sllv | I_srlv |I_srav | I_and | I_or |I_xor |I_nor | I_slt | I_sltu | I_jalr;
assign RegDst[1]=I_jal | I_jalr ;
assign ALUSrc=I_addu | I_subu | I_add | I_sub | I_mult | I_multu |I_div | I_divu | I_sll | I_srl | I_sra | I_sllv | I_srlv |I_srav | I_and | I_or |I_xor |I_nor | I_slt | I_sltu;
assign ALUOperation[0]=I_subu | I_addu | I_lw | I_sw | I_sb | I_sh | I_lb | I_lbu | I_lh | I_lhu | I_multu | I_divu | I_mfhi | I_mthi | I_sll | I_srl| I_srav | I_and | I_xor| I_addiu | I_xori | I_slt | I_slti;
assign ALUOperation[1]=I_subu | I_ori | I_add | I_mult | I_divu | I_mflo | I_mthi | I_srl | I_sra | I_srlv |I_or | I_xor | I_addi |I_xori | I_slt | I_slti;
assign ALUOperation[2]=I_ori | I_sub| I_mult | I_multu | I_divu | I_mtlo| I_sllv | I_srlv | I_srav | I_and | I_and | I_or | I_xor | I_andi | I_xori | I_slt | I_slti;
assign ALUOperation[3]=I_ori | I_div | I_mfhi | I_mflo | I_mthi | I_mtlo | I_and | I_or | I_xor | I_andi | I_xori | I_sltu | I_sltiu;
assign ALUOperation[4]=I_sll | I_srl | I_sra |I_sllv |I_srlv | I_srav| I_nor | I_slt | I_slti | I_sltu | I_sltiu;
assign ALUMD=I_mult | I_multu | I_div | I_divu | I_mfhi | I_mflo | I_mthi | I_mtlo;
assign CMPOperation[0]=I_blez | I_bgez | I_bne;
assign CMPOperation[1]=I_bgez | I_bgtz;
assign CMPOperation[2]=I_blez | I_bltz;
assign Word[0]=I_sh | I_lh | I_lhu;
assign Word[1]=I_sb | I_lb | I_lbu;
assign ReadSign=~I_lbu & ~I_lhu & ~I_ori & ~I_andi & ~I_xori;
assign Instype[0]=I_lw | I_beq | I_jal | I_lb | I_lbu | I_lh |I_lhu | I_blez |I_bltz | I_bgez | I_bgtz |I_bne | I_jalr;
assign Instype[1]=I_sw | I_beq | I_jal | I_sb | I_sh |I_mult | I_multu | I_div | I_divu | I_blez | I_bltz | I_bgez | I_bgtz | I_bne | I_jalr;
assign Instype[2]=I_beq | I_jr | I_mult| I_multu | I_div | I_divu | I_blez | I_bltz | I_bgez | I_bgtz | I_bne | I_jalr;




endmodule
