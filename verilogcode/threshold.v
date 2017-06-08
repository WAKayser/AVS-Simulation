module threshold (
clock,
reset,
freeze,
longEnergy,
TH
);


input wire clock, reset, freeze;
input wire signed [63:0] longEnergy;
output reg signed [63:0] TH;


always @ (posedge clock) begin
	if (reset == 1)
		TH <= 0;
	else if (freeze == 0)
		TH <= longEnergy;

end


endmodule

