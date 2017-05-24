module fsmTb;

reg clock, reset;
reg signed [15:0] stream;
wire eventDetected;

topLevel topLevel (.clock(clock),.reset(reset),.stream(stream),.eventDetected(eventDetected));


initial begin
	clock = 0;
	reset = 1;
	stream = 0;

	#10 reset = 0;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd1;
	#10 stream = 16'd5;
	#10 stream = 16'd15;
	#10 stream = -16'd5;
	#10 stream = 16'd0;
	#10 stream = 16'd18;
	#10 stream = 16'd20;
	#10 stream = -16'd17;
	#10 stream = -16'd33;
	#10 stream = -16'd5;
	#10 stream = 16'd0;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd20;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;
	#10 stream = 16'd0;

end

always
#5 clock =! clock;


endmodule
