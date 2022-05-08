

module multiplier7X7 (
input clk,reset,
input  [7:0]x,y,
output reg [13:0] out,output reg ready
);
reg [2:0] c=0 ;
//reg [
reg   [15:0] pp=0; //partial products
reg   [15:0] spp=0; //shifted partial products
reg   [15:0] prod=0;
reg [2:0] i=0,j=0;
reg flag=0, temp=0 ;
wire [7:0] inv_x ;
//assign x= (~x) +1'b1;
assign inv_x = (~x) +1'b1;
always@(posedge clk)
begin
if(reset)
        begin
          out=0; c=0; pp=0; flag=0; spp=0; i=0; j=0; prod=0; ready=0;
        end
else 
    begin
        if(!flag)
          begin
          c={y[1],y[0],1'b0};
         // y={y[6],y};
          end
          flag=1;
            case(c)
            ////////////////////////
            3'b000,3'b111: 
                    begin
                        if(i<4)
                        begin  i=i+1;
                               //if(i==3)
                               //c={y[2*i],y[2*i],y[2*i-1]};
                               //else
                               c={y[2*i+1],y[2*i],y[2*i-1]}; 
                        end
                        else
                               c=3'bxxx;
                    end
            ////////////////////////////
            3'b001,3'b010:
                begin
                    if(i<4)
                    begin
                        i=i+1;
                          // if(i==3)
                            //   c={y[2*i],y[2*i],y[2*i-1]};
                            //else
                               c={y[2*i+1],y[2*i],y[2*i-1]};
                        pp={{8{x[7]}},x};
                        if(i==1'b1)
                            prod=pp;
                        else
                            begin
                                temp=pp[15];
                                j=i-1;
                                j=j<<1;
                                spp=pp<<j;
                                spp={temp,spp[14:0]};
                                prod=prod+spp;
                            end
                    end
                    else 
                        c=3'bxxx;
                end
            ///////////////////////////
            3'b011:
            begin
                if(i<4)
                begin
                    i=i+1;
                        //if(i==3)
                          //     c={y[2*i],y[2*i],y[2*i-1]};
                        //else
                              c={y[2*i+1],y[2*i],y[2*i-1]};
                    pp={{7{x[7]}},x,1'b0};
                    if(i==1'b1)
                      prod=pp;
                    else
                        begin
                        temp=pp[15];
                        j=i-1;
                        j=j<<1;
                        spp=pp<<j;
                        spp={temp,spp[14:0]};
                        prod=prod+spp;
                    end
                end
                else 
                  c=3'bxxx;
            end
            ///////////////////////////
            3'b100:
            begin
                if(i<4)
                    begin
                    i=i+1;
                    //if(i==3)
                      //         c={y[2*i],y[2*i],y[2*i-1]};
                        //       else
                    c={y[2*i+1],y[2*i],y[2*i-1]};
                    pp={{7{inv_x[7]}},inv_x,1'b0};
                        if(i==1'b1)
                          prod=pp;
                        else
                            begin
                                temp=pp[15];
                                j=i-1;
                                j=j<<1;
                                spp=pp<<j;
                                spp={temp,spp[14:0]};
                                prod=prod+spp;
                            end
                    end
                else 
                    c=3'bxxx;
            end
            ////////////////////////////////////
            3'b101, 3'b110:
            begin
                if(i<4)
                begin
                        i=i+1;
                        //if(i==3)
                          //     c={y[2*i],y[2*i],y[2*i-1]};
                            //   else
                        c={y[2*i+1],y[2*i],y[2*i-1]};
                        pp={{8{inv_x[7]}},inv_x};
                    if(i==1'b1)
                        prod=pp;
                    else
                        begin
                            temp=pp[15];
                            j=i-1;
                            j=j<<1;
                            spp=pp<<j;
                            spp={temp,spp[14:0]};
                            prod=prod+spp;
                        end
                end
                else 
                  c=3'bxxx;
            end
            ////////////////
            default:
            begin
                out= prod[13:0];
                ready=1;
                end
            endcase
    end
end

endmodule
