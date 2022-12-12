module alu_tb;
  wire [15:0] result;
  reg [15:0] a,b;
  reg [2:0] opcode;
  reg reset, clk;
  logic x_bit, z_bit;
  
  alu des_ins (.*);
  
  initial begin
    clk <= 0; reset = 0; 
    forever #10 clk = ~clk;
  end
 
 initial begin
    #10 reset = 1;   	
    repeat(30) begin
      #10; 
      a = $random;
      b = $random;
      opcode = $random();
    end    
  end
  initial begin
    $monitor("RESET = %d, A = %d, B = %d, opcode = %d, result = %d, x_bit = %d, z_bit = %d", reset, a, b, opcode, result, x_bit, z_bit);
    #500 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
 /*********ASSERTION CHECKING*********/

//	IMMEDIATE ASSERTION
  always @ (*) begin
    assert ((a && b && opcode) !== 'x || 'z ) //$display("immediate passed");
  else $error("immediate functionality failed");
end

//CONCURRENT ASSERTION
  
  //////////////////////////////
  //	OPERATIONs CHECKING  ///
  //////////////////////////////
  property p_h0;
    @(posedge clk)
    (opcode == 3'h0) |-> !(result && x_bit);
  endproperty
  
  assert property (p_h0) //$display("p_h0 functionality passed");
    else $error("p_h0 func. failed");
    
  property p_h1;
    @(posedge clk)
    (opcode == 3'h1) |-> (result == a) ##0 !(x_bit);
  endproperty
    
  assert property (p_h1) //$display("p_h1 functionality passed");
    else $error("p_h1 func. failed");
  
  property p_h2;
    @(posedge clk)
    (opcode == 3'h2) |-> (result == a + b);
  endproperty
    
  assert property (p_h2) //$display("p_h2 functionality passed");
    else $error("p_h2 func. failed");
    
  property p_h3;
    @(posedge clk)
    (opcode == 3'h3) |-> (result == a - b);
  endproperty
    
  assert property (p_h3) //$display("p_h3 functionality passed");
    else $error("p_h3 func. failed");
      
  property p_h4;
    @(posedge clk)
        (opcode == 3'h4) |-> (result == a * b);
  endproperty
    
    assert property (p_h4) //$display("p_h4 functionality passed");
    else $error("p_h4 func. failed");
      
  property p_h5;
    @(posedge clk)
    (opcode == 3'h5) |-> (result == (a & b)) ##0 !(x_bit);
  endproperty
    
  assert property (p_h5) //$display("p_h5 functionality passed");
    else $error("p_h5 func. failed");
       
  property p_h6;
    @(posedge clk)
    (opcode == 3'h6) |-> (result == (a | b)) ##0 !(x_bit);
  endproperty
    
  assert property (p_h6) //$display("p_h6 functionality passed");
   else $error("p_h6 func. failed");
      
  property p_h7;
    @(posedge clk)
    (opcode == 3'h7) |-> (result == (a ^ b)) ##0 !(x_bit);
  endproperty
    
  assert property (p_h7) //$display("p_h7 functionality passed");
    else $error("p_h7 func. failed");
    
  ////////////////////////////////////
  ///	FUNCTIONALITIES TO VERIFY  ////
  ////////////////////////////////////

  property p1;
    @(posedge clk)
    reset |-> ((result) !== 'x || 'z);
  endproperty

  property p2;
    @(posedge clk)
    (result == 0) |-> z_bit;
  endproperty

 property ADD;
   @(posedge clk)
   ((result == a + b) > (2**16) - 1) |-> x_bit;
  endproperty

  property MULT;
    @(posedge clk)
    ((result == a * b) > (2**16) - 1) |-> x_bit;
  endproperty

  property SUB;
    @(posedge clk)
    (result == a < b) |-> x_bit;
  endproperty
  
  property NON_ARITHMETIC;
    @ (posedge clk)
    opcode == (3'h0 && 3'h1 && 3'h5 && 3'h6 && 3'h7) |-> !(x_bit);
  endproperty
  
  assert property (p1)
    //$display("p1 functionality passed");
    else
      $error("p1 func. failed");
  
   assert property (p2)
      //$display("p2 functionality passed");
    else
      $error("p2 func. failed");
      
       assert property (ADD)
         //$display("ADD functionality passed");
    else
      $error("ADD func. failed");
      
       assert property (MULT)
      //$display("MULT functionality passed");
    else
      $error("MULT func. failed");
      
       assert property (SUB)
         //$display("SUB functionality passed");
         
endmodule	
