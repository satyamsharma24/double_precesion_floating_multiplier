//Booth Multiplier 16-bit
module multiplier24X24 (
input clk,reset,
input  [24:0]x,y,
output reg [47:0] out,output reg ready
);
reg [2:0] c=0 ;

reg   [49:0] pp=0; //partial products
reg   [49:0] spp=0; //shifted partial products
reg   [49:0] prod=0;
reg [3:0] i=0,j=0;
reg flag=0, temp=0 ;
wire [24:0] inv_x ;
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
                        if(i<13)
                        begin  i=i+1;
                        if(i==12)
                             c={y[2*i],y[2*i],y[2*i-1]};
                              else
                               c={y[2*i+1],y[2*i],y[2*i-1]}; 
                        end
                        else
                               c=3'bxxx;
                    end
            ////////////////////////////
            3'b001,3'b010:
                begin
                    if(i<13)
                    begin
                        i=i+1;
                         if(i==12)
                             c={y[2*i],y[2*i],y[2*i-1]};
                              else
                            c={y[2*i+1],y[2*i],y[2*i-1]};
                        pp={{25{x[24]}},x};
                        if(i==1'b1)
                            prod=pp;
                        else
                            begin
                                temp=pp[49];
                                j=i-1;
                                j=j<<1;
                                spp=pp<<j;
                                spp={temp,spp[48:0]};
                                prod=prod+spp;
                            end
                    end
                    else 
                        c=3'bxxx;
                end
            ///////////////////////////
            3'b011:
            begin
                if(i<13)
                begin
                    i=i+1;
                     if(i==12)
                             c={y[2*i],y[2*i],y[2*i-1]};
                              else
                         c={y[2*i+1],y[2*i],y[2*i-1]};
                    pp={{24{x[24]}},x,1'b0};
                    if(i==1'b1)
                      prod=pp;
                    else
                        begin
                        temp=pp[49];
                        j=i-1;
                        j=j<<1;
                        spp=pp<<j;
                        spp={temp,spp[47:0]};
                        prod=prod+spp;
                    end
                end
                else 
                  c=3'bxxx;
            end
            ///////////////////////////
            3'b100:
            begin
                if(i<13)
                    begin
                    i=i+1;
                     if(i==12)
                             c={y[2*i],y[2*i],y[2*i-1]};
                              else
                    c={y[2*i+1],y[2*i],y[2*i-1]};
                    pp={{24{inv_x[24]}},inv_x,1'b0};
                        if(i==1'b1)
                          prod=pp;
                        else
                            begin
                                temp=pp[49];
                                j=i-1;
                                j=j<<1;
                                spp=pp<<j;
                                spp={temp,spp[48:0]};
                                prod=prod+spp;
                            end
                    end
                else 
                    c=3'bxxx;
            end
            ////////////////////////////////////
            3'b101, 3'b110:
            begin
                if(i<13)
                begin
                        i=i+1;
                         if(i==12)
                             c={y[2*i],y[2*i],y[2*i-1]};
                              else
                       c={y[2*i+1],y[2*i],y[2*i-1]};
                        pp={{25{inv_x[24]}},inv_x};
                    if(i==1'b1)
                        prod=pp;
                    else
                        begin
                            temp=pp[49];
                            j=i-1;
                            j=j<<1;
                            spp=pp<<j;
                            spp={temp,spp[47:0]};
                            prod=prod+spp;
                        end
                end
                else 
                  c=3'bxxx;
            end
            ////////////////
            default:
            begin
                out= prod[47:0];
                ready=1;
                end
            endcase
    end
end

endmodule
