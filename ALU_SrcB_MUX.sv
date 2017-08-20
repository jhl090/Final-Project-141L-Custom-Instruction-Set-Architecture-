// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    ALU_SrcA_SRO 

module ALU_SrcB_MUX (
   input [1:0] Sel_SrcB,  
   input [7:0] treg_in, immd_in, /*neg_in,*/ 
   output logic [7:0] data_out
   ); 

   always_comb begin
      if(Sel_SrcB == 2'b00) begin
        data_out = 1;
      end
     
      else if(Sel_SrcB == 2'b01) begin
        data_out = -1;
      end

      else if(Sel_SrcB == 2'b10) begin
        data_out = treg_in; 
      end

      else begin
        data_out = immd_in;
      end 
   end
endmodule 
