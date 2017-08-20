// Engineer(s): Triet Bach, Jim Lee, Aaron Yang
// Module: flip

module flip (
  input [7:0] in,
  output wire [7:0] out
  );

  assign out = ~in; 
  
endmodule
