// Create Date:    05/05/17
// Engineer(s):	   Triet Bach, Jim Lee, Aaron Yang
// Module Name:    ALU_SRO 

module ALU_SRO (
        input start_alu, Cin_alu, OVin_alu, addrc_alu,
	input [2:0] op,
        input signed [7:0] inputA,
        input signed [7:0] inputB,
	output wire zero, LTout_alu,
        output logic OVout_alu, Cout_alu, 
	output logic signed [7:0] data_out 
	); 

        wire [7:0] OVin_ext = {OVin_alu, 7'b0000000}; 
        wire Cin = (start_alu == 1'b1)? 1'b0 : Cin_alu; 
        wire Cout; 

	// always set the lt flag for BLT and zero flag for BNE
        assign LTout_alu = (inputA < inputB)? 1'b1 : 1'b0; 
        assign zero = (inputA != inputB)? 1'b1 : 1'b0;
        CLA_8bit add(Cin, inputA, inputB, Cout, sum); 

        always_comb begin 
           OVout_alu = 1'b0; 
           Cout_alu = Cout;
           data_out = 8'b00000000;   
  
           // Execute ADDI/ADDR without concern for carry-out
           if(op == 3'b000 && !addrc_alu) begin
              data_out = inputA + inputB;
           end

           // Execute ADDRC
           else if(op == 3'b000 && addrc_alu) begin
              data_out = inputA + inputB + Cin_alu; 
           end

           // Execute STRC
	   else if(op == 3'b001) begin
              data_out = (inputA[3:0] ^ inputB[3:0]); 
           end

	   // Execute SLLI
           else if(op == 3'b010) begin     
               OVout_alu = inputA[7]; 
               data_out = inputA << inputB;
           end

           // Execute SLLO
           else if(op == 3'b011) begin 
              data_out = (inputA << inputB) + OVin_alu;
           end 

           // Execute SRA
           else if(op == 3'b100) begin
              OVout_alu = inputA[0];
              data_out = $signed(inputA) >>> inputB;
	   end

           // Execute SRO
           else if(op == 3'b101) begin
               data_out = OVin_ext | (inputA >> inputB); 
           end 

           // Execute SRL
           else if(op == 3'b110) begin
               OVout_alu = inputA[0];
               data_out = inputA >> inputB; 
           end

           // Execute logical and operation
           else if(op == 3'b111) begin
              data_out = inputA - inputB;
           end

	end 
endmodule 


