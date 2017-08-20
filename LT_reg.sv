// Create Date:    05/05/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    LT_reg

module LT_OV_reg (
   input clk, Cout_from_alu, Cin_w, lt_in, lt_w, ov_in, ov_w,
   output logic lt_out, ov_out, Cin_to_alu
   //output wire Cin_to_alu
   );    

   always_ff @(posedge clk) begin
     //Cin_to_alu <= Cout_from_alu; 

     if(lt_w) begin
        lt_out <= lt_in;
        ov_out <= ov_out;
        Cin_to_alu <= Cin_to_alu;
     end
    
     else if(ov_w) begin
        ov_out <= ov_in;
        lt_out <= lt_out;
        Cin_to_alu <= Cin_to_alu; 
     end
     
     else if(Cin_w) begin
        Cin_to_alu <= Cout_from_alu;
        ov_out <= ov_out;
        lt_out <= lt_out;  
     end
  
     else begin
        lt_out <= lt_out;
        ov_out <= ov_out;
     end
   end
 
endmodule 