module matlabdata ();

  reg clock, reset;
  reg signed [15:0] vectorx, vectory, pressure;
  
  wire dingetje;

  integer in, statusI, out;
  

topLevel topLevel (
.clock(clock),
.reset(reset),
.stream(pressure),
.eventDetected(dingetje)
);

  initial begin
    clock = 1;
    reset = 1;
    
    {vectorx, vectory, pressure} = 0;
    #100 reset = 0;
    in  = $fopen("../testbenchfiles/testdata.dat", "r");
    out = $fopen("../testbenchfiles/detected.dat", "w");
    while ( ! $feof(in)) begin @ (negedge clock);
      statusI = $fscanf(in,"%d %d %d\n", vectorx, vectory, pressure);
      $fwrite(out, "%d\n", dingetje);
    end 
    $fclose(in);
    $stop;
  end
  
  always #5 clock = !clock;


endmodule
