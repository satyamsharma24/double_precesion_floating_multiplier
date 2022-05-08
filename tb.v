
module tb_top();
reg clk,reset;
reg  [52:0] x,y;
wire [105:0]out;
//fp_mult dut(clk,reset,x,y,out);
mul53X53 dut(clk,reset,x,y,out);
always #5 clk=~clk;
initial
begin
 x=0;y=0;clk=0;reset=1;
#8 reset=0;x={42'b0,11'b10000111011};y={48'b0,5'b10011};
#150 x={52'hFFAB000000000,1'b0};y={52'hFACB000000000,1'b0};
end
endmodule*/

module tb_main();
reg clk,reset;
reg  [63:0] x,y;
wire [63:0]out;
fp_mult dut(clk,reset,x,y,out);
always #5 clk=~clk;
initial
begin
 x=0;y=0;clk=0;reset=1;
#8 reset=0;x=64'h4011000000000000;y=64'h4004000000000000;  //(4.25*2.5)
//x=64'h3FF8000000000000;y=64'h3FF8000000000000;    //(1.5*1.5)
//#150 x={52'hFFAB000000000,1'b0};y={52'hFACB000000000,1'b0};
end
endmodule
