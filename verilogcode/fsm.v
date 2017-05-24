module fsmDing (
clock,
reset,
initDone,
energy,
TH,
eventDetected
);


input wire clock, reset, initDone;
input wire [63:0] energy, TH;
output reg eventDetected;

parameter initialize = 2'b00, noEvent = 2'b01, duringEvent = 2'b10;
parameter factor = 3, endFactor = 2;

reg [1:0] state;

always @ (posedge clock)
begin: FSM
if (reset == 1) begin
	state <= initialize;
	eventDetected <= 0;
end else begin

	case(state)

		initialize:	if (initDone) begin
					state <= noEvent;
					eventDetected <= 0;
				end else begin
					state <= initialize;
					eventDetected <= 0;
				end

		noEvent: 	if (energy > TH * factor) begin
					state <= duringEvent;
					eventDetected <= 1;
				end else begin
					state <= noEvent;
					eventDetected <= 0;
				end

		duringEvent:	if (energy < TH * endFactor) begin			// event end
					state <= noEvent;
					eventDetected <= 0;
				end else begin
					state <= duringEvent;
					eventDetected <= 1;					
					// doe fft
					// frequentie afschatting
					// bw schatting
					// verstuur data
				end


		endcase
	end
end

endmodule
