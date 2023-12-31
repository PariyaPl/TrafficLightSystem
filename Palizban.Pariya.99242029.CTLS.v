module CTLS(
input clk,
input rst,
input [7:0] CA,
input [7:0] CB,
output reg [2:0] LA, //G:100 - Y:010 - R:001
output reg [2:0] LB
);
reg [7:0] c = 'b0;
reg d=0;
always @(posedge clk or negedge clk) begin
	if(~rst) begin
		{c,LA,LB}<=14'b00000000001100;
	end 
	else begin
		if (c==CB-1'b1 && {LA,LB}==6'b001100) begin //RG
			{LA,LB}<=6'b001010; //RY
		end
		if (c==CA-1'b1 && {LA,LB}==6'b100001) begin //GR
			{LA,LB}<=6'b010001; //YR
		end
		if (c==CB && {LA,LB}==6'b001010)begin //RY
			{LA,LB}<=6'b001001; //RR
			d<=0;
			c=8'b11111110;
		end
		if (c==CA && {LA,LB}==6'b010001)begin //YR
			{LA,LB}<=6'b001001; //RR
			d<=1;
			c=8'b11111110;
		end
		if (c==8'b11111111 && d==0) begin //RR
			{LA,LB}<=6'b100001; //GR
		end
		if (c==8'b11111111 && d==1) begin //RR
			{LA,LB}<=6'b001100; //RG
		end
	c<=c+1'b1;
	end
end
endmodule