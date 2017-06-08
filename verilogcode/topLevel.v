module topLevel (
clock,
reset,
serial,
eventDetected,
uart_out,
initDone2
);

input wire clock, reset, serial;
output reg eventDetected, initDone2;
output uart_out;

wire tempEventDetected, tempBuffer, dataReady, valid, wordValid;
wire signed [15:0] firstShort, lastShort, firstLong, lastLong;
wire signed [63:0] shortEnergy, longEnergy, TH;
wire signed [7:0] halfWord;
wire signed [15:0] fullWord;

parameter shortSize = 400, longSize = 2000, factor = 15, endFactor = 15, compFactor = 10, triggerCount = 1, CLKS_PER_BIT = 125;// !!!! BIJ AANPASSEN, AANPASSING IN BUFFER NODIG !!!! OOK FACTOR ENDFACTOR = *10 FACTOR !!!!

fsmDing #(shortSize, longSize, factor, endFactor, compFactor, triggerCount) fsm (
	.clock(clock),
	.reset(reset),
	.initDone(initDone),
	.energy(shortEnergy),
	.TH(TH),
	.eventDetected(tempEventDetected),
	.freeze(freeze)
);

buffer #(shortSize, longSize) buffer (
	.clock(clock),
	.reset(reset),
	.stream(fullWord),
	.wordValid(wordValid),
	.firstShort(firstShort),
	.lastShort(lastShort),
	.firstLong(firstLong),
	.lastLong(lastLong),
	.initDone(initDone),
	.update(update)
);

signalEnergy #(shortSize) shortEnergyCalc (
	.clock(clock),
	.reset(reset),
	.update(update),
	.first(firstShort),
	.last(lastShort),
	.energy(shortEnergy)
);

threshold threshold (
	.clock(clock),
	.reset(reset),
	.freeze(freeze),
	.longEnergy(longEnergy),
	.TH(TH)
);

signalEnergy #(longSize) longEnergyCalc (
	.clock(clock),
	.reset(reset),
	.update(update),
	.first(firstLong),
	.last(lastLong),
	.energy(longEnergy)
);


uart_rx #(CLKS_PER_BIT) uart_rx (           // #(clks_per_bit)
	.i_Clock(clock),
	.i_Rx_Serial(serial),
	.o_Rx_DV(valid),
	.o_Rx_Byte(halfWord)
);

half2word half2word (
	.clock(clock),
	.reset(reset),
	.valid(valid),
	.halfWord(halfWord),
	.fullWord(fullWord),
	.wordValid(wordValid)
);

uart_tx #(CLKS_PER_BIT) uart_tx (
	.i_Clock(clock),
	.i_Tx_DV(valid),
	.i_Tx_Byte(halfWord), 
	.o_Tx_Active(unused1),
	.o_Tx_Serial(uart_out),
	.o_Tx_Done(unused3)
);

dfswt #(128, 7) dfswt (
	.clock(clock),
	.reset(reset),
	.enable(eventDetected),				// & wordValid
	.datain(fullWord),
	.smooth(freqbin)
);




always @ (posedge clock) begin
	eventDetected <= tempEventDetected;
	
	if (reset == 1)
	   initDone2 <= 0;
	else   if (freqbin > 200)
	           initDone2 <= 1;
	       else
	           initDone2 <= 0;
	   
end

endmodule
