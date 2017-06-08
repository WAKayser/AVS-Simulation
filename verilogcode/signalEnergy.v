module signalEnergy (
clock,
reset,
first,
last,
update,
energy
);

parameter windowSize = 15;
integer i = 0;
reg signed [63:0] tempEnergy;

input wire clock, reset, update;
input wire signed [15:0] first, last;
output reg signed [63:0] energy;

always @ (posedge clock) begin
	if (reset == 1) begin
		energy <= 0;
		tempEnergy <= 0;
	end else begin if (update == 1)
		tempEnergy <= tempEnergy + ((first**2) - (last**2));
		energy <= tempEnergy;
	end
end

endmodule

