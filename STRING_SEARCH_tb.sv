// Engineer(s): Triet Bach, Jim Lee, Aaron Yang
// Module Name: stringsearch_rev_tb

module stringsearch_rev_tb;

bit  [511:0] string1;		   // data_mem[32:95]
bit  [  3:0] sequence1;		   // data_mem[9][3:0]
wire [  7:0] count_beh;
logic[  7:0] count_DUT;
bit          clk, start;
wire         halt;
bit  [  7:0] score;            // how many correct trials
// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed

Top_Lvl_SRO DUT(
  .start_tp(start),
  .clk,
  .halt_tp(halt)
  );

// purely behavioral model to match
// its output(s) = benchmark for your design
stringsearch DUT1(
  .string1 ,
  .sequence1,
  .count (count_beh)
   );

initial begin
  #10ns  
  start = 1'b1;

  #10ns 
  for(int i=0; i<256; i++)		 // clear data memory
     DUT.d_mem.my_memory[i] = 8'b0;

   // now declare the searchable string and the 4-bit pattern itself
  string1   = {{64{4'b1100}},{64{4'b0001}}};//{{102{5'b01001}},2'b0};//{128{4'b1001}};
  sequence1 = 4'b1001;
  
  // load 4-bit pattern into memory address 9, LSBs
  DUT.d_mem.my_memory[9] = {4'b0,sequence1};  // load "Waldo"

// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
     DUT.d_mem.my_memory[95-i] = string1[7+8*i-:8];

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
     DUT.reg_file.regs[i] = 8'b0;

// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_STRINGSEARCH.txt", DUT.instr_MEM.instr_arr);

  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  count_DUT = DUT.d_mem.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  #10ns for(int j=32; j<96; j++)
           for(int k=7; k>=0; k--)
             $writeb(DUT.d_mem.my_memory[j][k]);
  #10ns $display();
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  
  // shall we have another go?
  #10ns start = 1'b1;
  string1   = {{102{5'b01101}},2'b0};//{128{4'b1001}};
  sequence1 = 4'b1101;
  #10ns;

  // load 4-bit pattern into memory address 9, LSBs
  DUT.d_mem.my_memory[9] = {4'b0,sequence1};  // load "Waldo"

  // load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
     DUT.d_mem.my_memory[95-i] = string1[7+8*i-:8];

  // clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
     DUT.reg_file.regs[i] = 8'b0;

  // load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_STRINGSEARCH.txt", DUT.instr_MEM.instr_arr);
  //  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);

  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  count_DUT = DUT.d_mem.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
     score++;
  #10ns;

  // one more time!
  start = 1'b1;
  string1   = '1;//{{102{5'b01001}},2'b0};//{128{4'b1001}}; 		'h1 = (binary): 00000...1    '1	= binary 111111...111
  sequence1 = 4'b1111;
  // load 4-bit pattern into memory address 9,
  #10ns DUT.d_mem.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
  // load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
     DUT.d_mem.my_memory[95-i] = string1[7+8*i-:8];
  // clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
     DUT.reg_file.regs[i] = 8'b0;
  // load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instrMem_init_STRINGSEARCH.txt",  DUT.instr_MEM.instr_arr);
  //  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(halt);
  #10ns  count_DUT = DUT.d_mem.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
     score++;
  
  // DO NOT EDIT BELOW
  #10ns	$stop;
end

always begin
  #5ns  clk = 1'b1;
  #5ns  clk = 1'b0;
end

endmodule

