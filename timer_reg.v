
`timescale 1ns / 1ps
module timer(
output reg data_out,
input timer_en,rst,clk, [1:0]mode,[7:0]data_in
);
reg data_out_reg,timer_en_reg;
reg [7:0]count;
assign timer_en= timer_en_reg;
always @ (posedge clk)begin
if(rst) begin
count<=0;
data_out<=0;
data_out_reg=0; 
timer_en_reg<=0;
end
else
count<=data_in;
end
always @ (posedge clk)begin
if({timer_en, mode}==3'b100) begin//mode 0
if(count==8'hff)begin
count<=0; 
timer_en_reg<=0;
end
else begin
count<=count+1;
end
end
//
else if({timer_en, mode}==3'b101) begin//mode 1
if(count==8'hff)begin
count<=0; 
data_out<=1;
end
else begin
count<=count+1;
data_out<=1;
end
end
else if({timer_en, mode}==3'b110) begin//mode 2
if(count==data_in)begin
data_out_reg<=data_out_reg+1;
count<=0;
end 
else begin
count<=count+1;
end
end
else 
begin
count<=0;
end
end

always @ (posedge clk)
begin
if({timer_en, mode}==3'b100) begin//mode 0
if(count==8'hff)begin
data_out<=1;
end
else begin
data_out<=0;
end
end
else if({timer_en, mode}==3'b101) begin//mode 1
if(count==8'hff)
begin
data_out<=1;
end
else 
begin
data_out<=0;
end
end
else if({timer_en, mode}==3'b110) begin//mode 2
data_out<=data_out_reg;
end
else 
data_out<=0;
end
endmodule

