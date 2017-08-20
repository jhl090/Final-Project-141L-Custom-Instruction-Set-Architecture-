// Create Date:    05/05/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Program Counter SRO 

module Pgm_Ctr_SRO(
   input clk, start_pc, halt_pc, br_taken_pc, j_taken_pc, 
   input [15:0] next_addr_pc, 
   output logic[15:0] instr_addr_pc
   );

  wire [15:0] start_addr_pc = 16'b0000000000000000;

  always_ff @(posedge clk) begin
     if(start_pc) begin 
        instr_addr_pc <= start_addr_pc;		
     end

     else if(halt_pc) begin
        instr_addr_pc <= instr_addr_pc;			
     end 

     else if(br_taken_pc || j_taken_pc)  begin
        instr_addr_pc <= next_addr_pc; 
     end
  
     else begin
 	instr_addr_pc <= next_addr_pc + 1;
     end
   end

endmodule 