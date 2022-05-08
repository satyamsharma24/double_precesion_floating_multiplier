
module mul53X53(clk,reset,x,y,out,ready);
input clk,reset;
input [52:0]x,y;
output [105:0]out;
output ready;
wire [91:0]out1;
wire [52:0]out2,out3;
wire [13:0]out4;
wire [53:0]inter;
wire ready1,ready2,ready3,ready4;
multiplier46X46 dut1(clk,reset,x[45:0],y[45:0],out1,ready1);
multiplier46X7 dut2(clk,reset,{1'b0,x[45:0]},{1'b0,y[52:46]},out2,ready2);
multiplier46X7 dut3(clk,reset,{1'b0,y[45:0]},{1'b0,x[52:46]},out3,ready3);
multiplier7X7 dut4(clk,reset,{1'b0,y[52:46]},{1'b0,x[52:46]},out4,ready4);

assign inter={out2}+{out3};
assign out={14'b0,out1}+{inter,46'b0}+{out4,92'b0};
assign ready=ready1 & ready2 & ready3 & ready4;
endmodule
