`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/05/14 18:47:57
// Design Name:
// Module Name: control32
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


module control32(Opcode, Function_opcode, Jr, RegDST, ALUSrc, MemtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp);

input[5:0]   Opcode;            // 来自IFetch模块的指令高6bit, instruction[31..26]
input[5:0]   Function_opcode;  	// 来自IFetch模块的指令低6bit, 用于区分r-类型中的指令, instructions[5..0]
output       Jr;         	    // 为1表明当前指令是jr, 为0表示当前指令不是jr
output       RegDST;            // 为1表明目的寄存器是rd, 否则目的寄存器是rt
output       ALUSrc;            // 为1表明第二个操作数（ALU中的Binput）是立即数（beq, bne除外）, 为0时表示第二个操作数来自寄存器
output       MemtoReg;          // 为1表明需要从存储器或I/O读数据到寄存器
output       RegWrite;   	    // 为1表明该指令需要写寄存器
output       MemWrite;          // 为1表明该指令需要写存储器
output       Branch;            // 为1表明是beq指令, 为0时表示不是beq指令
output       nBranch;           // 为1表明是bne指令, 为0时表示不是bne指令
output       Jmp;               // 为1表明是J指令, 为0时表示不是J指令
output       Jal;               // 为1表明是Jal指令, 为0时表示不是Jal指令
output       I_format;          // 为1表明该指令是除beq, bne, LW, SW之外的其他I-类型指令
output       Sftmd;             // 为1表明是移位指令, 为0表明不是移位指令
output[1:0]  ALUOp;             // 是R-类型或I_format=1时位1（高bit位）为1,  beq、bne指令则位0（低bit位）为1

wire R_format, Lw, Sw;

assign R_format = (Opcode == 6'b00_0000);
assign I_format = (Opcode[5:3] == 3'b001);

assign Lw = (Opcode == 6'b10_0011);
assign Sw = (Opcode == 6'b10_1011);
assign Jr = ((Opcode == 6'b00_0000) && (Function_opcode == 6'b00_1000));
assign Jmp = (Opcode == 6'b00_0010);
assign Jal = (Opcode == 6'b00_0011);
assign Branch = (Opcode == 6'b00_0100);
assign nBranch = (Opcode == 6'b00_0101);

assign RegDST = R_format;       // ???
assign ALUSrc = (I_format || Lw || Sw);
assign MemtoReg = Lw;
assign RegWrite = Lw || Jal || I_format || (R_format && !Jr);
assign MemWrite = Sw;
assign Sftmd = (R_format && ((Function_opcode == 6'b00_0000) || (Function_opcode == 6'b00_0010) || (Function_opcode == 6'b00_0100) || (Function_opcode == 6'b00_0110) || (Function_opcode == 6'b00_0011) || (Function_opcode == 6'b00_0111)));
assign ALUOp = {(R_format || I_format), (Branch || nBranch)};

endmodule
