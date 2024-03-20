`timescale 1ns/1ns

module counter_pwm
#( parameter N=10)(
output reg [N-1:0]count_out,
input clk,reset);

always@(posedge clk) begin

if(reset | count_out==511)
count_out<=0;

else count_out<=count_out+1;

end

endmodule


module counter_tb ;


reg clk,reset;
wire [9:0] count_out;

counter_pwm dut(.count_out(count_out),.clk(clk),.reset(reset));

initial begin

clk<=0;
forever #5 clk<=~clk;

end


initial begin

reset<=1;
#20 reset<=0; 
#260 reset<=1;
#10 reset<=0;
#400 $stop;

end
endmodule