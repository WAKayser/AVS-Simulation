module fsmDing (
clock,
reset,
initDone,
energy,
TH,
eventDetected,
freeze
);


input wire clock, reset, initDone;
input wire signed [63:0] energy, TH;
output reg eventDetected, freeze;

parameter shortSize = 15, longSize = 31, factor = 5, endFactor = 5, compFactor = 1, triggerCount = 1;
parameter initialize = 2'b00, noEvent = 2'b01, preTrigger = 2'b10, duringEvent = 2'b11;

reg [1:0] state;
reg count;

always @ (posedge clock)
begin: FSM
if (reset == 1) begin
	state <= initialize;
	eventDetected <= 0;
	freeze <= 0;
	count <= 0;
end else begin
    
    	eventDetected <= 0;
	case(state)

		initialize:	if (initDone)
					   state <= noEvent;
				
		noEvent: 	if (energy * longSize * compFactor > TH * factor * shortSize) 
					state <= preTrigger;

		preTrigger:	begin
					freeze <= 1;
					if (energy * longSize * compFactor > TH * factor * shortSize) begin
						if (count < triggerCount)
							count <= count + 1;
						else begin
							state <= duringEvent;
							count <= 0;
						end

					end else begin
						state <= noEvent;
						count <= 0;
					end
				end

		duringEvent:	begin
		             		freeze <= 1;
		             		if (energy * longSize * compFactor < TH * endFactor * shortSize) 		// event end
						    state <= noEvent;

					else begin
						state <= duringEvent;
						eventDetected <= 1;
					end
				end


		endcase
	end
end

endmodule
