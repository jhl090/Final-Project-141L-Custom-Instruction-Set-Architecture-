// Create Date:    05/21/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    Carry Look Ahead Adder 4-bit

module CLA_4bit(
   input Cin,
   input [3:0]A, B,
   output Cout, Pout, Gout,
   output [3:0]S
   );

   wire [3:0] Gtemp, Ptemp, Ctemp;

   assign Gtemp = A & B;
   assign Ptemp = A ^ B;

   assign Ctemp[0] = Cin;
   assign Ctemp[1] = Gtemp[0] | (Ptemp[0] & Ctemp[0]); 
   assign Ctemp[2] = Gtemp[1] | (Ptemp[1] & Gtemp[0]) | (Ptemp[1] & Ptemp[0] & Ctemp[0]); 
   assign Ctemp[3] = Gtemp[2] | (Ptemp[2] & Gtemp[1]) | (Ptemp[2] & Ptemp[1] & Gtemp[0]) |
                     (Ptemp[2] & Ptemp[1] & Ptemp[0] & Ctemp[0]); 
   assign Cout = Gtemp[3] | (Ptemp[3] & Gtemp[2]) | (Ptemp[3] & Ptemp[2] & Gtemp[1]) | 
                 (Ptemp[3] & Ptemp[2] & Ptemp[1] & Gtemp[0]) | 
                 (Ptemp[3] & Ptemp[2] & Ptemp[1] & Ptemp[0] & Ctemp[0]); 

   assign Pout = Ptemp[3] & Ptemp[2] & Ptemp[1] & Ptemp[0];
   assign Gout = Gtemp[3] | (Ptemp[3] & Gtemp[2]) | (Ptemp[3] & Ptemp[2] & Gtemp[1]) | 
                 (Ptemp[3] & Ptemp[2] & Ptemp[1] & Gtemp[0]);
   assign S = Ptemp ^ Ctemp;

endmodule 