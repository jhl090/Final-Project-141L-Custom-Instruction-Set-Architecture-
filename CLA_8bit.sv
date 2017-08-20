// Create Date:    05/21/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Carry Look Ahead Adder 4-bit

module CLA_8bit(
   input Cin,
   input [7:0]Data1, Data2,
   output Cout, 
   output [7:0]Sum
   );

   wire c3, p3, g3, p7, g7;
  
   CLA_4bit CLA1(Cin, Data1[3:0], Data2[3:0], c3, p3, g3, Sum[3:0]);
   CLA_4bit CLA2(c3, Data1[7:4], Data2[7:4], Cout, p7, g7, Sum[7:4]);

endmodule 