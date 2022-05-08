module fp_mult(clk);
input clk;
reg reset;
wire [63:0]a,b;
reg [63:0]out;
wire ready1;
reg done,temp;
reg [6:0]count;
reg sign;
reg [11:0]exp_add;
reg [10:0]exp_final;
wire [105:0]man_mul;
reg [51:0]mantissa;
wire ready;
reg [6:0]shift;
mul53X53 dut(clk,reset,{1'b1,a[51:0]},{1'b1,b[51:0]},man_mul,ready);  //Mantissa multiplier
//assign ready1=ready;
//assign out=man_mul[105:42];



//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
vio_0 your_instance_name (
  .clk(clk),                // input wire clk
  .probe_in0(out),    // input wire [63 : 0] probe_in0
  .probe_in1(reset),    // input wire [0 : 0] probe_in1
  .probe_out0(a),  // output wire [63 : 0] probe_out0
  .probe_out1(b),  // output wire [63 : 0] probe_out1
  .probe_out2(ready1)  // output wire [0 : 0] probe_out2
);
// INST_TAG_END ------ End INSTANTIATION Template ---------




always @(posedge clk)
begin
    if(reset)
        begin
            done=0; temp=0; count=0;
        end
    else 
        begin
         if(ready==1 && done==0) begin  
                   temp=man_mul[105-count];
                   if(temp)
                       begin
                        done=1;
                        shift=104-(count+51);
                        mantissa=man_mul>>shift;
                        end
                   else
                         count=count+1;
               end
            else if(done)
               begin             
                  exp_add=a[62:52]+b[62:52];
                  exp_final=exp_add-12'd1022-{5'b0,count[6:0]};  // Normalising
                  sign=a[63]^b[63];                              //Sign calculation
                  out={sign,exp_final,mantissa};           //Rounding off---Truncation
                 end
             else
                 done=0;
          end
       end
endmodule
    
