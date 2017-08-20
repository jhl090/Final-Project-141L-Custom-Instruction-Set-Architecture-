// Create Date:    06/04/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    dataMem

module dataMem(
    input clk, memRead, memWrite,
    input [7:0] dataAddr, writeData,              
    output logic [7:0] readDataOut      
    );
    
    logic [7:0] my_memory[255];

    /*initial 
        $readmemh("dataram_init.txt", my_memory); */

    always_comb begin
       if(memRead) begin
          readDataOut = my_memory[dataAddr];
	  // $display("Memory read M[%d] = %d", dataAddr, readDataOut);
       end 
 
       else begin
          readDataOut = 8'b00000000;
       end
    end

    always_ff @(posedge clk) begin
       if(memWrite) begin
          my_memory[dataAddr] = writeData;
	  // $display("Memory write M[%d] = %d", dataAddr, writeData);
       end
    end

endmodule
