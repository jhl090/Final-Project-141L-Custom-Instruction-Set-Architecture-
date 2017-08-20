// Create Date: 06/03/17
// Engineer(s): Triet Bach, Jim Lee, Aaron Yang
// Module Name: DIV_SHIFT_tb

module division_shift_tb; 

bit [15:0] dividend;
bit [7:0] divisor;
wire [15:0] quotient;
logic [15:0] quotient_DUT;
bit clk, start;
wire halt;
bit  [7:0] score;            // how many correct trials

// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
Top_Lvl_SRO DUT(
  .start_tp(start),
  .clk,
  .halt_tp(halt)
  );

// behavioral model to match
divison DUT1(
	dividend,divisor,quotient
   );

initial begin
  #10ns  
  start = 1'b1;

  #10ns 
  for (int i=0; i<256; i++)		 // clear data memory
     DUT.d_mem.my_memory[i] = 8'b0;

// you may preload any desired constants int
// you may preload any desired constants into your data_mem here
//    ...
// case 1
  dividend = 16'h44AB;
  divisor = 8'h02;
  DUT.d_mem.my_memory[128] = 8'h44;
  DUT.d_mem.my_memory[129] = 8'hAB;
  DUT.d_mem.my_memory[130] = 8'h02;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.regs[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_DIVISION.txt", DUT.instr_MEM.instr_arr);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  quotient_DUT = {DUT.d_mem.my_memory[126],DUT.d_mem.my_memory[127]};
  #10ns  $display(quotient,quotient_DUT);
  if(quotient == quotient_DUT)	 // score another successful trial
    score++;

// case 2
  #10ns  start = 1'b1;
  #10ns dividend = 16'h7FFF;
  divisor = 8'h7F;
  DUT.d_mem.my_memory[128] = dividend[15:8];
  DUT.d_mem.my_memory[129] = dividend[ 7:0];
  DUT.d_mem.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.regs[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_DIVISION.txt", DUT.instr_MEM.instr_arr);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  quotient_DUT = {DUT.d_mem.my_memory[126],DUT.d_mem.my_memory[127]};
  #10ns  $display(quotient,quotient_DUT);
  if(quotient == quotient_DUT)	 // score another successful trial
    score++;

// case 3
  #10ns  start = 1'b1;
  #10ns dividend = 16'h6F;
  divisor = 8'h70;
  DUT.d_mem.my_memory[128] = dividend[15:8];
  DUT.d_mem.my_memory[129] = dividend[ 7:0];
  DUT.d_mem.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.regs[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_DIVISION.txt", DUT.instr_MEM.instr_arr);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  quotient_DUT = {DUT.d_mem.my_memory[126],DUT.d_mem.my_memory[127]};
  #10ns  $display(quotient,quotient_DUT);
  if(quotient == quotient_DUT)	 // score another successful trial
    score++;

// case 4
  #10ns  start = 1'b1;
  #10ns dividend = 16'h100;
  divisor = 8'h10;
  DUT.d_mem.my_memory[128] = dividend[15:8];
  DUT.d_mem.my_memory[129] = dividend[ 7:0];
  DUT.d_mem.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.regs[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_DIVISION.txt", DUT.instr_MEM.instr_arr);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  quotient_DUT = {DUT.d_mem.my_memory[126],DUT.d_mem.my_memory[127]};
  #10ns  $display(quotient,quotient_DUT);
  if(quotient == quotient_DUT)	 // score another successful trial
    score++;

// case 5
  #10ns  start = 1'b1;
  #10ns dividend = 16'h5A5A;
  divisor = 8'h78;
  DUT.d_mem.my_memory[128] = dividend[15:8];
  DUT.d_mem.my_memory[129] = dividend[ 7:0];
  DUT.d_mem.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.reg_file.regs[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_DIVISION.txt", DUT.instr_MEM.instr_arr);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  quotient_DUT = {DUT.d_mem.my_memory[126],DUT.d_mem.my_memory[127]};
  #10ns  $display(quotient,quotient_DUT);
  if(quotient == quotient_DUT)	 // score another successful trial
    score++;
          
  
  #10ns $stop;
end

always begin
  #5ns  clk = 1'b1;
  #5ns  clk = 1'b0;
end

endmodule