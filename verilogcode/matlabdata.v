module matlabdata ();

  reg clock, reset;
  reg signed [15:0] vectorx, vectory, pressure;
  
  wire devent;
  wire [5:0] freqbin;

  integer in, statusI, out;
  

	topLevel topLevel (
		.clock(clock),
		.reset(reset),
		.stream(pressure),
		.eventDetected(devent));

	dfswt #(128, 7) dfswt (
			.clock(clock),
			.reset(reset),
			.enable(devent),
			.datain(pressure),
			.smooth(freqbin));

	initial begin
		clock = 1;
		reset = 1;

		{vectorx, vectory, pressure} = 0;
		#100 reset = 0;
		in  = $fopen("../testbenchfiles/testdata.dat", "r");
		out = $fopen("../testbenchfiles/detected.dat", "w");
		while ( ! $feof(in)) begin @ (negedge clock);
			statusI = $fscanf(in,"%d %d %d\n", vectorx, vectory, pressure);
			$fwrite(out, "%d %d\n", devent, freqbin);
		end 
		$fclose(in);
		$finish;
	end

	always #5 clock = !clock;


endmodule
