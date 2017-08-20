// Create Date:    05/25/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    instr_ROM

module instr_ROM (
   input [15:0] instr_addr_ROM,
   output logic [8:0] instr_out_ROM
   );
	 
   // declare ROM array
   logic[8:0] instr_arr[300];

   assign instr_out_ROM = instr_arr[instr_addr_ROM];

endmodule
