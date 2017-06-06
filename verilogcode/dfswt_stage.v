module dfswt_stage(clock, reset, enable, datain, magnitude);
	
	parameter step = 1;
	parameter points = 8;
	parameter bits = 3;

	input clock, reset, enable;
	input signed [15:0] datain;
	reg signed [31:0] accx, accy;
	output signed [31:0] magnitude;

	reg [bits -1:0] countx, county;

	always @(posedge clock) begin
		if (reset & !enable) begin
			countx <= points / 4;
			county <= 0;
		end else begin
			countx <= countx + step;
			county <= county + step;
		end
	end

	always @(posedge clock) begin
		if (reset & !enable) begin
			accx <= 0;
			accy <= 1;
		end else begin
			accx <= (countx[bits-1]) ? accx - datain : accx + datain;
			accy <= (county[bits-1]) ? accy - datain : accx + datain;
		end
	end

	assign magnitude = (accx >>> 16) ** 2 + (accy >>> 16) ** 2;

endmodule
