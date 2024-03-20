`timescale 1ns/1ns

module comparator_pwm
#(parameter N=10)(
output reg comp_out,
input [N-1:0] count_in,duty_in);

assign comp_out = (count_in<duty_in);

endmodule 

module comparator_tb;

reg [10:0]count_in,duty_in;
wire comp_out;

comparator_pwm dut(.comp_out(comp_out),.count_in(count_in),.duty_in(duty_in));

initial begin

count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);
#10count_in=($random%512); duty_in=($random%512);

end


endmodule 