// Create Date:    05/22/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    SignExtend

module Sign_Extend (
   input [4:0] in,   
   output wire [7:0] out
   ); 
    
   wire [4:0] temp = in;
   assign out = {temp[4], temp[4], temp[4], in};

endmodule 