// Create Date:    06/05/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    LUT

module LUT (
   input [4:0] idx,
   output logic [15:0] targ_addr
   ); 
   
   logic [7:0] addrs[32];

   /*** CORDIC BRANCH TARGETS ***/
   /*
   assign addrs[0] = 32;
   assign addrs[1] = 35;
   assign addrs[2] = 37;
   assign addrs[3] = 41;
   assign addrs[4] = 53;
   assign addrs[5] = 77;
   assign addrs[6] = 81;
   assign addrs[7] = 93;
   assign addrs[8] = 109;
   assign addrs[9] = 113;
   assign addrs[10] = 121;
   assign addrs[11] = 128;
   assign addrs[12] = 140;
   assign addrs[13] = 144;
   assign addrs[14] = 156;
   assign addrs[15] = 170;
   assign addrs[16] = 174;
   assign addrs[17] = 186;
   assign addrs[18] = 202;
   assign addrs[19] = 206;
   assign addrs[20] = 214;
   assign addrs[21] = 230;
   assign addrs[22] = 249;
   assign addrs[23] = 253; 
   */

   

   /*** STRING SEARCH TARGETS ***/
   assign addrs[0] = 39;
   assign addrs[1] = 45;
   assign addrs[2] = 50;
   assign addrs[3] = 58;
   assign addrs[4] = 66;
   assign addrs[5] = 71;
   assign addrs[6] = 76;

   assign targ_addr = addrs[idx];

endmodule 