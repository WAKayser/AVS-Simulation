module topLevel (
clock,
reset,
stream,
eventDetected
);

input wire clock, reset;
input wire [15:0] stream;
output reg eventDetected;

wire tempEventDetected, tempBuffer, dataReady;
wire signed [15:0] firstShort, lastShort, firstLong, lastLong;
wire signed [63:0] shortEnergy, longEnergy, TH;

parameter shortSize= 100, longSize = 1000;			// !!!! BIJ AANPASSEN, AANPASSING IN BUFFER NODIG !!!!

fsmDing fsm (
	.clock(clock),
	.reset(reset),
	.initDone(initDone),
	.energy(shortEnergy),
	.TH(TH),
	.eventDetected(tempEventDetected)
);

buffer #(shortSize, longSize) buffer (
	.clock(clock),
	.reset(reset),
	.stream(stream),
	.firstShort(firstShort),
	.lastShort(lastShort),
	.firstLong(firstLong),
	.lastLong(lastLong),
	.initDone(initDone)
);

signalEnergy #(shortSize) shortEnergyCalc (
	.clock(clock),
	.reset(reset),
	.first(firstShort),
	.last(lastShort),
	.energy(shortEnergy)
);

threshold threshold (
	.clock(clock),
	.reset(reset),
	.freeze(tempEventDetected),					// koppel aan eventDetected
	.longEnergy(longEnergy),
	.TH(TH)
);

signalEnergy #(longSize) longEnergyCalc (
	.clock(clock),
	.reset(reset),
	.first(firstLong),
	.last(lastLong),
	.energy(longEnergy)
);


always @ (posedge clock)
	eventDetected <= tempEventDetected;


endmodule
