module multiplier46X46 (
input clk,reset,
input  [45:0]x,y,
output [91:0] out,output ready
);
//reg [22:0]a0,b0,a1,b1;
wire ready1,ready2,ready3;
wire [23:0]a10,b10;
wire [47:0]m00,m11,m10;
wire [47:0]inv_m00,inv_m11;
wire [47:0]inter;

multiplier24X24 dut1(clk,reset,{2'b00,x[22:0]},{2'b00,y[22:0]},m00,ready1);
multiplier24X24 dut2(clk,reset,{2'b00,x[45:23]},{2'b00,y[45:23]},m11,ready2);
multiplier24X24 dut3(clk,reset,{1'b0,a10},{1'b0,b10},m10,ready3);

assign a10=x[22:0]+x[45:23];
assign b10=y[22:0]+y[45:23];

assign inv_m00=(~m00) +1'b1;
assign inv_m11=(~m11) +1'b1;
assign inter=m10+inv_m11+inv_m00;
assign out={m11[45:0],m00[45:0]}+{21'b0,inter,23'b0};
assign ready=ready1 & ready2 & ready3;
endmodule
