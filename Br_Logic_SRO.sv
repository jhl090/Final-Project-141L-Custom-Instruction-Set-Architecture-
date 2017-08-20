// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Branch Logic 

module Br_Logic_SRO (
   input br_lt_in, br_ne_in, lt, zero,   
   output sel
   ); 
   
   assign sel = (br_ne_in & zero) ^ (br_lt_in & lt); 

endmodule 
