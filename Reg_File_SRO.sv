// Create Date:    05/01/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    reg_file_sro 					  

module reg_file_sro (
	input clk, write_en, acc, mar, mra, mem,
	input [3:0] raddr1, raddr2, waddr,  
        input [7:0] wdata,
	output logic [7:0] regf_out1, regf_out2
	); 
 
        // 3 special purpose regs + 13 temp regs
	logic [7:0] regs[16];     		// regs[0] is $zero 
						// regs[1] is $mem 
                                                // regs[2] is $acc
			    			// regs[3] is $t0
                                                // regs[4] is $t1                        
                                                // regs[5] is $t2
                                                // regs[6] is $t3
                                                // regs[7] is $t4
                                                // regs[8] is $t5
                                                // regs[9] is $t6
                                                // regs[10] is $t7
                                                // regs[11] is $t8
                                                // regs[12] is $t9
                                                // regs[13] is $t10
                                                // regs[14] is $t11
                                                // regs[15] is $t12
        assign regf_out1 = regs[raddr1];
        assign regf_out2 = regs[raddr2];

	always_ff @ (posedge clk) begin
	   //regs[0] <= 8'b00000000;

           if(write_en && acc) begin
              regs[2] <= wdata;
           end

           // overwrite dest reg with wdata
	   else if(write_en && !acc) begin
              regs[waddr] <= wdata;
           end  	

	   // move contents of specified temp reg to $acc
           else if(mar) begin
              regs[waddr] <= regs[2];
           end 
		
           // move contents of $acc to specified temp reg
	   else if(mra) begin
              regs[2] <= regs[waddr]; 
	   end 
        end 


endmodule  
		