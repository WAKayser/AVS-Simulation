module threshold (
clock,
reset,
freeze,					// koppel aan eventDetected
longEnergy,
TH
);


input wire clock, reset, freeze;
input wire [63:0] longEnergy;
output reg [63:0] TH;


always @ (posedge clock) begin
	if (reset == 1)
		TH <= 0;
	else if (freeze == 0)
		TH <= longEnergy;

end


endmodule
