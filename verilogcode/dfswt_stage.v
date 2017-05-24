module dfswt_stage(clock, reset, enable, datain, accumulator);
	
	parameter step = 1;
	parameter points = 8;
	parameter countbits = 3;

	input clock, reset, enable;
	input signed [15:0] datain;
	output reg signed [31:0] accumulator;

	reg [countbits -1:0] count;

	always @(posedge clock) begin
		if (reset)
			count <= points / 4;
		else if (enable)
			count <= count + step;
	end

	always @(posedge clock) begin
		if (reset)
			accumulator <= 0;
		else if (enable) begin
			if (count[countbits-1])
				accumulator <= accumulator - datain;
			else
				accumulator <= accumulator + datain;
		end
	end
endmodule
