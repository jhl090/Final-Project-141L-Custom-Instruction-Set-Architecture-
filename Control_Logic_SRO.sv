// Create Date:    05/25/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Control_Log_SRO 

module Control_Log_SRO (
   input f, 
   input [3:0] opcode, raddr1_in, 

   output logic reg_w, reg_acc, reg_mar, reg_mra, reg_mem,
                mem_w, mem_r, mem_trsf, j, start_alu_ctrl, 
                addrc_ctrl, Cin_w, lt_w, ov_w, br_ne, br_lt, halt_ctrl,
   output logic [1:0] ALU_inA, ALU_inB,
   output logic [2:0] ALUop_in,
   output logic [3:0] raddr1_out, raddr2_out, waddr_out
   ); 

   always_comb begin
      /***                DEFAULT CONFIGS                    ***/
      // Program Counter (PC) Control Signal:
      halt_ctrl = 1'b0;

      // Branch Logic Control Signals:
      br_ne = 1'b0;
      br_lt = 1'b0;
 
      // Jump Control Signal:
      j = 1'b0; 

      // Register File Control Signals:
      reg_w = 1'b0;
      reg_acc = 1'b0;
      reg_mar = 1'b0;
      reg_mra = 1'b0;
      reg_mem = 1'b0; 
      raddr1_out = 4'b0000;
      raddr2_out = 4'b0000; 
      waddr_out = 4'b0000;

      // ALU_MUXs Control Signals:
      ALU_inA = 2'b00;
      ALU_inB = 2'b10; 

      // ALU Control Signals:
      start_alu_ctrl = 1'b1;
      ALUop_in = 3'b000;
      addrc_ctrl = 1'b0;

      // LT/OV Reg Control Signals:
      Cin_w = 1'b0;
      lt_w = 1'b0; 
      ov_w = 1'b0; 

      // Data Memory Control Signals:
      mem_w = 1'b0;
      mem_r = 1'b0;

      // Data Transfer MUX Control Signal:
      mem_trsf = 1'b0; 

      // LD configs
      if(opcode == 4'b1000 && f == 1'b0) begin
         reg_w = 1'b1;
         reg_mem = 1'b1;
         raddr1_out = 4'b0001;
         raddr2_out = 4'b0000; 
         waddr_out = raddr1_in;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         mem_r = 1'b1;
         mem_trsf = 1'b1; 
      end 
   
      // ST configs	  
      else if(opcode == 4'b1000 && f == 1'b1) begin
         reg_mem = 1'b1;
         raddr1_out = 4'b0001;
         raddr2_out = raddr1_in; 
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         mem_w = 1'b1; 
      end 
           
      // MAR configs
      else if(opcode == 4'b1001 && f == 1'b0) begin
         reg_mar = 1'b1;
         waddr_out = raddr1_in; 
      end

      // MRA configs
      else if(opcode == 4'b1001 && f == 1'b1) begin
         reg_mra = 1'b1;
         waddr_out = raddr1_in; 
      end
        
      // INC configs
      else if(opcode == 4'b1011 && f == 1'b0) begin
         reg_w = 1'b1; 
         raddr1_out = raddr1_in; 
         raddr2_out = 4'b0000;
         waddr_out = raddr1_in; 
         ALU_inA = 2'b00;
         ALU_inB = 2'b00;
         mem_trsf = 1'b0;
      end
           
      // DEC configs 
      else if(opcode == 4'b1011 && f == 1'b1) begin
         reg_w = 1'b1; 
         raddr1_out = raddr1_in; 
         raddr2_out = 4'b0000;
         waddr_out = raddr1_in; 
         ALU_inA = 2'b00;
         ALU_inB = 2'b00;
         ALUop_in = 3'b111;    
         mem_trsf = 1'b0;
      end 

      // ADDI configs 
      else if(opcode == 4'b0000) begin 
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = 4'b0000;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b11;
         mem_trsf = 1'b0; 
      end

      // ADDR configs
      else if(opcode == 4'b1100 && f == 1'b0) begin
         Cin_w = 1'b1;
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         mem_trsf = 1'b0;
      end 

      // ADDRC configs
      else if(opcode == 4'b1010 && f == 1'b0) begin
         start_alu_ctrl = 1'b0;
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         addrc_ctrl = 1'b1;
         mem_trsf = 1'b0;
      end
      
      // SUB configs
      else if(opcode == 4'b1111 && f == 1'b0) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         ALUop_in = 3'b111;
         mem_trsf = 1'b0; 
      end 

      // BNE configs 
      else if(opcode == 4'b0001) begin
         br_ne = 1'b1;
         raddr1_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
      end 

      // BLT configs 
      else if(opcode == 4'b0010) begin
         br_lt = 1'b1;
         ALU_inA = 2'b11; 
         ALU_inB = 2'b00;
      end 

      // J instr configs
      else if(opcode == 4'b0110) begin
         j = 1'b1;
      end

      // SLTI configs
      else if(opcode == 4'b0011) begin
         raddr1_out = 4'b0010;
         raddr2_out = 4'b0000;
         ALU_inA = 2'b00;
         ALU_inB = 2'b11;
         lt_w = 1'b1;
      end 

      // SLTR configs
      else if(opcode == 4'b1100 && f == 1'b1) begin
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         lt_w = 1'b1; 
      end 

      // SLLI configs
      else if(opcode == 4'b0100) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = 4'b0000;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b11;
         ALUop_in = 3'b010;    
         mem_trsf = 1'b0; 
         ov_w = 1'b1; 
      end 

      // SLLO configs 
      else if(opcode == 4'b0101) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = 4'b0000;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b11;
         ALUop_in = 3'b011;    
         mem_trsf = 1'b0; 
      end 

      // SRA configs
      else if(opcode == 4'b1101 && f == 1'b0) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         ALUop_in = 3'b100;    
         mem_trsf = 1'b0; 
         ov_w = 1'b1; 
      end 

      // SRO configs
      else if(opcode == 4'b1101 && f == 1'b1) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         ALUop_in = 3'b101;    
         mem_trsf = 1'b0; 
      end 
		
      // SRL configs	  
      else if(opcode == 4'b1110 && f == 1'b0) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         ALUop_in = 3'b110;    
         mem_trsf = 1'b0;  
         ov_w = 1'b1; 
      end 

      // STRC configs 
      else if(opcode == 4'b1110 && f == 1'b1) begin
         reg_w = 1'b1;
         reg_acc = 1'b1;
         raddr1_out = 4'b0010;
         raddr2_out = raddr1_in;
         waddr_out = 4'b0010;
         ALU_inA = 2'b00;
         ALU_inB = 2'b10;
         ALUop_in = 3'b001;
         mem_trsf = 1'b0;
      end 
                  
      // FL configs
      else if(opcode == 4'b1010 && f == 1'b1) begin
         reg_w = 1'b1;
         raddr1_out = raddr1_in;
         waddr_out = raddr1_in;
         ALU_inA = 2'b10;
         ALU_inB = 2'b10;
         mem_trsf = 1'b0;
      end

      // SUS configs
      else if(opcode == 4'b1111 && f == 1'b1) begin
         halt_ctrl = 1'b1;
      end

   end
endmodule
