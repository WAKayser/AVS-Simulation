module dspstub(clock, reset, vectorx, vectory, pressure, dingetje);

	input clock, reset;
	input signed [15:0] vectory, vectorx, pressure;
	output signed [15:0] dingetje;

	assign dingetje = vectorx / 2;

endmodule
