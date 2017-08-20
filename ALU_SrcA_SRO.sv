// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    ALU_SrcA_SRO 

module ALU_SrcA_SRO (
   input [1:0] Sel_SrcA,  
   input [7:0] inputA, neg_inputA, 
   output logic [7:0] data_out
   ); 

   always_comb begin
      if(Sel_SrcA == 2'b00) begin
        data_out = 1;
      end
     
      else if(Sel_SrcA == 2'b01) begin
        data_out = -1;
      end

      else if(Sel_SrcA == 2'b10) begin
        data_out = inputA; 
      end

      else begin
        data_out = neg_inputA;
      end 
   end
endmodule 