module alu (result, x_bit, z_bit, reset, clk, a, b, opcode);
  output reg [15:0] result;
  output reg x_bit;
  output reg z_bit;
  
  input reset, clk;
  input [15:0] a,b;
  input [2:0] opcode;

  
  always @ (*) begin
    if(reset == 1) begin //[
  case (opcode)
    //NOP
  	3'h0: begin 
      result = 0;
       x_bit = 0;
    end
    
    //PASS
	3'h1: begin
      result = a; 
       x_bit = 0;
    end
    
    //ADD
  	3'h2: begin
      		result = a + b;
   			if ((a + b) > (2**16) - 1)
      			x_bit = 1;
      	else
            x_bit = 0;
    end
    
    //SUB
  	3'h3: begin
      		result = a - b;
      		if(a < b)
        		x_bit = 1;
      		else
            x_bit = 0;
    end
    
    //MULT
  	3'h4: begin
      		result = a * b;
      		if ((a * b) > (2**16) - 1)
      			x_bit = 1;
      		else
            x_bit = 0;
    end
    
    //AND
  	3'h5: begin
      		result = a & b;
      		 x_bit = 0;
    end
    
    //OR
  	3'h6: begin
      		result = a | b;
      		 x_bit = 0;
    end
    
    //XOR
  	3'h7: begin
      		result = a ^ b;
      		 x_bit = 0;
    end
  endcase
       end //]
  end
  endmodule                                                                       
