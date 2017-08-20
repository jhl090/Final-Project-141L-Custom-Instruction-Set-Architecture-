// Create Date:    05/25/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Top_Lvl_SRO 

module Top_Lvl_SRO (
      input start_tp, clk,
      output logic halt_tp
      ); 

      wire [15:0] instr_addr_tp, next_addr_tp, pc_next_addr_tp, lut_out; 
      wire [8:0] ass_instr;   
      wire [7:0] wdata, rdata, regf_out1, regf_out2, se_out, sum_out, 
                 fl_out, ALU_MUXA_out, ALU_MUXB_out, ALU_result;
      wire taken, br_lt_tp, br_ne_tp, reg_w, reg_acc, reg_mar, reg_mra, reg_mem, 
           mem_w, mem_r, mem_trsf, addrc_tp, j_MUX_tp, Cin_w_tp, lt_w_tp, ov_w_tp, LT, LT_p, 
           start_alu_tp, Cin_tp, Cout_tp, OV, OVin, OV_p, zero, br_MUX_tp;
      wire [1:0] ALU_inA, ALU_inB;
      wire [2:0] ALUop_in;
      wire [3:0] raddr1_out, raddr2_out, waddr_out;         
   
      Pgm_Ctr_SRO PC1(
         .clk,
         .start_pc(start_tp), 
         .next_addr_pc(pc_next_addr_tp),
         .halt_pc(halt_tp), 
         .br_taken_pc(br_MUX_tp),
         .j_taken_pc(j_MUX_tp),
         .instr_addr_pc(instr_addr_tp)
      );             

      instr_ROM instr_MEM(
         .instr_addr_ROM(instr_addr_tp),
         .instr_out_ROM(ass_instr)
      );

      Control_Log_SRO ctrl_log(
         .f(ass_instr[0]),
         .opcode(ass_instr[8:5]),
         .raddr1_in(ass_instr[4:1]),
         .reg_w,
         .reg_acc,
         .reg_mar,
         .reg_mra,
         .reg_mem,
         .ALU_inA,
         .mem_w,
         .mem_r,
         .mem_trsf,
         .j(j_MUX_tp),
         .start_alu_ctrl(start_alu_tp),
         .addrc_ctrl(addrc_tp),
         .Cin_w(Cin_w_tp),
         .lt_w(lt_w_tp), 
         .ov_w(ov_w_tp),
         .br_lt(br_lt_tp),
         .br_ne(br_ne_tp), 
         .halt_ctrl(halt_tp),
         .ALU_inB,
         .ALUop_in,
         .raddr1_out,
         .raddr2_out,
         .waddr_out
      );

      reg_file_sro reg_file(
         .clk,
         .write_en(reg_w),
         .acc(reg_acc),
         .mar(reg_mar),
         .mra(reg_mra),
         .mem(reg_mem),
         .raddr1(raddr1_out),
         .raddr2(raddr2_out),
         .waddr(waddr_out),
         .wdata,
         .regf_out1,
         .regf_out2
      );

      Sign_Extend se(
         .in(ass_instr[4:0]),
         .out(se_out)
      );
    
      flip fl(
         .in(regf_out1),
         .out(fl_out)
      );

      ALU_SrcA_MUX srcA(
         .Sel_SrcA(ALU_inA),
         .reg_in(regf_out1),
         .fl_in(fl_out), 
         .data_out(ALU_MUXA_out)
      );

      ALU_SrcB_MUX srcB(
         .Sel_SrcB(ALU_inB),
         .treg_in(regf_out2),
         .immd_in(se_out),
         .data_out(ALU_MUXB_out)
      );

      ALU_SRO alu(
         .start_alu(start_alu_tp),
         .Cin_alu(Cin_tp),
         .OVin_alu(OV_p),
         .addrc_alu(addrc_tp),
         .op(ALUop_in),
         .inputA(ALU_MUXA_out),
         .inputB(ALU_MUXB_out),
         .LTout_alu(LT),
         .zero,
         .OVout_alu(OV), 
         .data_out(ALU_result),
         .Cout_alu(Cout_tp)
      );

      LT_OV_reg lt(
         .clk,
         .Cout_from_alu(Cout_tp),
         .lt_in(LT), 
         .ov_in(OV),
         .Cin_w(Cin_w_tp),
         .lt_w(lt_w_tp),
         .ov_w(ov_w_tp),
         .lt_out(LT_p),
         .ov_out(OV_p),
         .Cin_to_alu(Cin_tp)
      );

      dataMem d_mem(
         .clk,
         .memRead(mem_r),
         .memWrite(mem_w),
         .dataAddr(regf_out1),
         .writeData(regf_out2),
         .readDataOut(rdata)
      );

      TWO_ONE_MUX write_mux(
         .Sel(mem_trsf),
         .inputA(ALU_result),
         .inputB(rdata),
         .data_out(wdata)
      );
      
      Br_Logic_SRO br_log(
         .br_lt_in(br_lt_tp),
         .br_ne_in(br_ne_tp), 
         .lt(LT_p),
         .zero,
         .sel(br_MUX_tp)
      );

      LUT lut(
         .idx(ass_instr[4:0]),
         .targ_addr(lut_out)
      ); 

      TWO_ONE_MUX_SXTEEN pc_next1(
         .Sel(br_MUX_tp),
         .inputA(instr_addr_tp),
         .inputB(lut_out),
         .data_out(next_addr_tp)
      );

      TWO_ONE_MUX_SXTEEN pc_next2( 
         .Sel(j_MUX_tp),
         .inputA(next_addr_tp),
         .inputB(lut_out),
         .data_out(pc_next_addr_tp)
      );

endmodule 