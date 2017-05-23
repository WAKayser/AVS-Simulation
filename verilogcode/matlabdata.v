module matlabdata ();

	reg clock, reset;
  reg signed [15:0] vectorx, vectory, pressure;
  
  wire signed [15:0] dingetje;

  integer in, statusI, out;
  
  // umts_top umts_top(.clock(clock), .reset(reset),
  //       .sample_i(sample_i), .sample_q(sample_q),
  //       .frame(frame), .strobe(strobe));

  dspstub dspstub(.clock(clock), .reset(reset), 
  					.vectorx(vectorx), .vectory(vectory), .pressure(pressure),
  					.dingetje(dingetje));
  
  initial begin
    clock = 1;
    reset = 1;
    
    #10 reset = 0;
  end
  
  initial begin
    {vectorx, vectory, pressure} = 0;
    #100 reset = 0;
    in  = $fopen("../testbenchfiles/testdata.dat", "r");
    out = $fopen("../testbenchfiles/detected.dat", "w");
    while ( ! $feof(in)) begin @ (negedge clock);
      statusI = $fscanf(in,"%d %d %d\n", vectorx, vectory, pressure);
      $fwrite(out, "%d\n", dingetje);
    end 
    $fclose(in);
    $finish;
  end
  
  always #5 clock = !clock;


endmodule
