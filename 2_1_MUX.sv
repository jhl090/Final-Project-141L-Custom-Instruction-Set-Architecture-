// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    2_1_MUX

module TWO_ONE_MUX (
   input Sel,  
   input [7:0] inputA, inputB, 
   output logic [7:0] data_out
   ); 

   always_comb begin
      if(!Sel) begin
        data_out = inputA;
      end

      else begin
        data_out = inputB; 
      end
   end
endmodule 
