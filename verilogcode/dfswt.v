module dfswt(clock, reset, enable, datain, frequencybin);

  parameter points = 8;
  parameter log = 3;

  input clock, reset, enable;
  
  input signed [15:0] datain;
  output reg signed [log-2:0] frequencybin;
   
  wire signed [31:0] acc [points/2:0];
  reg signed [31:0] highacc;
  integer i;

  // get all the accumulated values
  genvar n;
  generate
  for(n = 0; n < points / 2; n = n + 1) begin: stage_s
    dfswt_stage #(n, points, log) 
      dfswt_stage (.clock(clock), .reset(reset), .enable(enable),
        .datain(datain), .accumulator(acc[n]));
	end
	endgenerate

  always @(posedge clock) begin
    if (reset) begin
      frequencybin = 0;
      highacc = 0;
    end else begin
      frequencybin = 0;
      highacc = 0;
      for (i=0; i < points/2; i = i + 1) begin
        if (acc[i] > highacc) begin
          frequencybin = i;
          highacc = acc[i];
        end
      end
    end
  end
endmodule 
