// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    ALU_SrcA_SRO 

module ALU_SrcA_MUX (
   input [7:0] reg_in, fl_in, 
   input [1:0] Sel_SrcA,
   output logic [7:0] data_out
   ); 

   always_comb begin
      if(Sel_SrcA == 2'b00) begin
        data_out = reg_in;
      end

      else if(Sel_SrcA == 2'b01) begin
        data_out = -reg_in;
      end

      else if(Sel_SrcA == 2'b10) begin
        data_out = fl_in;
      end  
     
      else begin
        data_out = 8'b00000000;
      end

   end
endmodule 
