module buffer (
clock,
reset,
stream,
firstShort,
lastShort,
firstLong,
lastLong,
initDone
);

parameter shortSize = 15, longSize = 31;

input wire clock, reset;
input wire [15:0] stream;
output reg [15:0] firstShort, lastShort, firstLong, lastLong;
output reg initDone;
reg [15:0] initCount;				// !!!! MOET KUNNEN TELLEN TOT (shortSize+longSize+2) * 16 !!!!
reg [(shortSize+longSize+2)*16 - 1:0] buffer;

always @ (posedge clock) begin
	if (reset == 1) begin
		buffer <= 0;
		firstShort <= 0;
		lastShort <= 0;
		firstLong <= 0;
		lastLong <= 0;
		initCount <= 0;
		initDone <= 0;
	end else begin				
		buffer <= buffer >> 16;		
		buffer[(shortSize+longSize+2)*16 - 1 : (longSize+shortSize+1)*16] <= stream;
		firstShort <= buffer[(shortSize+longSize+2)*16 - 1 : (longSize+shortSize+1)*16];
		lastShort <= buffer[(longSize+2)*16 - 1 : (longSize+1)*16];
		firstLong <= buffer[(longSize+1)*16 - 1 : longSize*16];
		lastLong <= buffer[15:0];
		
		if (initDone == 0) begin
			initCount <= initCount + 1;
			if (initCount == shortSize+longSize+2)
				initDone <= 1;
		end
	end
end



endmodule
		