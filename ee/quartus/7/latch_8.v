module  latch_8(qout,data,clk,oe);
output[7:0]  qout;
input[7:0]  data;
input  clk;
input oe;
reg[7:0]  qout;
always @(clk or data)
    	begin
if (clk && oe)  qout<=data;
  		end
endmodule
