module smoother(clock, reset, datain, dataout);

	parameter bus = 6;

	input clock, reset;
	input [bus-1:0] datain;
	output reg [bus-1:0] dataout;

	reg [bus-1:0] previous, fallback;

	always @(posedge clock) begin
		if (reset) begin
			{previous, fallback, dataout} = 0;
		end else begin
			if (previous == datain) begin
				dataout <= datain;
				fallback <= datain;
				previous <= datain;
			end else begin
				dataout <= fallback;
				fallback <= fallback;
				previous <= datain;
			end
		end
	end
endmodule
