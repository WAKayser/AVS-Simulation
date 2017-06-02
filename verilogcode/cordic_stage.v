// Wouter Kayser 12-10-16

// Eerste versie kwam van source code
// Is nu veel korter en kan dus ook achteruit werken
// is makkelijk te parametriseren voor 16 of 24 bits

module cordic_stage(clock, reset, xi, yi, zi, constant, xo, yo, zo);
  
  parameter shift = 1;
  parameter rotating = 1;
   
  input clock, reset;

  input signed [17:0] xi,yi;
  input signed [14:0] zi;
  input signed [15:0] constant;

  output reg signed [17:0] xo,yo;
  output reg signed [14:0] zo;
  
  reg signed [17:0] xa, ya;
  
  wire di = rotating ? zi[14] : yi[17];
   
  always @(posedge clock, posedge reset) begin
      xa = di ? -(yi >>> shift) : (yi >>> shift);
      ya = di ? -(xi >>> shift) : (xi >>> shift); 
      xo <= #1 reset ? 18'd0 : xi + xa;
      yo <= #1 reset ? 18'd0 : yi - ya;
      zo <= #1 reset ? 15'd0 : di ? zi + constant[14:0] : zi - constant[14:0];
  end
endmodule
