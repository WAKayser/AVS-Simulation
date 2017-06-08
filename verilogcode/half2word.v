module half2word (
clock,
reset,
valid,
halfWord,
fullWord,
wordValid
);



input wire clock, reset, valid;
input wire signed [7:0] halfWord;
output reg signed [15:0] fullWord;
output reg wordValid;

reg [1:0] state;
reg [7:0] halfWord1, halfWord2;



always @ (posedge clock) begin
		wordValid <= 0;
	if (reset == 1) begin
		fullWord <= 0;
		halfWord1 <= 0;
		halfWord2 <= 0;
		state <= 2'b00;
	end else begin
		if ((state == 2'b00) & (valid == 1)) begin
			halfWord1 <= halfWord;
			state <= 2'b01;
		end else if ((state == 2'b01) & (valid == 1)) begin
			halfWord2 <= halfWord;
			state <= 2'b10;
		end else if (state == 2'b10) begin
			fullWord[15:8] <= halfWord1;			// = MSB FIRST, MOET MOGELIJK ANDERSOM ZIJN
			fullWord[7:0] <= halfWord2;
			wordValid <= 1;
			state <= 2'b00;
		end
	end
end
endmodule










