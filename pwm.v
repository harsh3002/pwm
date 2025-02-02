`timescale 1ns/1ns


module pwm
#(parameter N=9)( 
output  pwm_out,
input clk,reset,
input [N-1:0] duty_in);

wire [N-1:0] count_out;
wire load_duty;
reg [N-1:0] duty_temp;

assign load_duty=(count_out==0);

always@(*) begin

if(load_duty) duty_temp=duty_in;
end

counter_pwm count(.count_out(count_out),.clk(clk),.reset(reset));
comparator_pwm comp(.comp_out(pwm_out),.count_in(count_out),.duty_in(duty_temp));


endmodule 


module pwm_tb();

reg [8:0] duty_in;
reg clk,reset;
wire pwm_out;


pwm dut(.duty_in(duty_in),.pwm_out(pwm_out),.clk(clk),.reset(reset));


initial begin

clk=1;
forever #5 clk=~clk;

end

initial begin

reset=1; 
#5 reset =0; 
duty_in=0;
forever #5600 duty_in=$random%511;

end



endmodule

module counter_pwm
#( parameter N=9)(
output reg [N-1:0]count_out,
input clk,reset);

always@(posedge clk) begin

if(reset | count_out==511)
count_out<=0;

else  
count_out<=count_out+1;



end

endmodule


module comparator_pwm
#(parameter N=9)(
output  comp_out,
input [N-1:0] count_in,
input [N-1:0] duty_in);

assign comp_out = (count_in<duty_in);

endmodule 