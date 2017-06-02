// Wouter Kayser 12-10-16

// Was eerst een module van de broncode
// Nu aangepast zodat het ook andersom werkt
// Daarnaast is het ook heel veel korter dan eerst.
// Het aantal stages is nu ook variabel

// Kan ook aangepast worden zodat het met 24 bits ipv 16 bits werkt 

module cordic(clock, reset, xi, yi, zi, xo, yo, zo );
  
  parameter rotating = 1;
  parameter stages = 12;

  input clock, reset;
  
  input signed [15:0] xi, yi, zi;
  output signed [15:0] xo, yo, zo;
   
  wire signed [17:0] x [stages:0];
  wire signed [17:0] y [stages:0];
  wire signed [14:0] z [stages:0];  
  wire signed [15:0] c [15:0];
  
    // Dit zijn de benodigde constanten dit is met atan berekend. 
    // Hiervoor kan ook een set voor 24 bits gebruikt worden
    // Een andere manier hiervoor is readmemh maar de implementatie hiervan verschilt 
  assign {c[00], c[01], c[02], c[03]} = {16'd8192, 16'd4836, 16'd2555, 16'd1297}; 
  assign {c[04], c[05], c[06], c[07]} = {16'd651, 16'd326, 16'd163, 16'd81};
  assign {c[08], c[09], c[10], c[11]} = {16'd41, 16'd20, 16'd10, 16'd5};
  assign {c[12], c[13], c[14], c[15]} = {16'd3, 16'd1, 16'd1, 16'd0};

    // Hiervoor moet je kennis hebben van het algoritme
  wire mirror = rotating ? ~^(zi[15:14]) : (xi[15]);

  assign x[0] = mirror ? -{{2{xi[15]}},xi} : {{2{xi[15]}},xi};
  assign y[0] = mirror ? -{{2{yi[15]}},yi} : {{2{yi[15]}},yi};
  assign z[0] = zi[14:0];

  genvar n;
  generate
  for(n = 0; n < stages; n = n + 1) begin: stage_s
    cordic_stage #(n, rotating) 
      cordic_stage (.clock(clock), .reset(reset), .constant(c[n]),
        .xi(x[n]), .yi(y[n]), .zi(z[n]), .xo(x[n+1]), .yo(y[n+1]), .zo(z[n+1]));
	end
	endgenerate

  assign {xo, yo} = {x[stages][16:1], y[stages][16:1]};
  assign zo = z[stages] <<< 1;	
endmodule 
