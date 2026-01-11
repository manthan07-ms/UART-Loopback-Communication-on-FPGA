module UART_rec(clk,rst,rx,data_out,done);
input clk,rst,rx;
output reg [7:0]data_out;
output reg done;

parameter Idle = 2'b00, Start = 2'b01, Data = 2'b10, Stop = 2'b11;

reg [1:0]state;
reg [12:0]baud_rate;
reg [2:0]bit_ind;

always @(posedge clk or negedge rst) begin

if(!rst) begin
state <= Idle;
done <= 0;
baud_rate <= 0;
bit_ind <= 0;
data_out <= 0;
end

else begin

case(state)

Idle: begin
if(rx == 1) begin
state <= Idle;
done <= 0;
baud_rate <= 0;
bit_ind <= 0;
end
else begin
state <= Start;
baud_rate <= 0;
end
end

Start: begin
if(baud_rate == 2603) begin
if(rx == 0) begin
state <= Data;
done <= 0;
baud_rate <= 0;
end
else state <= Idle;
end
else begin
baud_rate <= baud_rate + 1;
end
end

Data: begin
if(baud_rate == 5207) begin
if(bit_ind == 7) begin
data_out[bit_ind] <= rx;
bit_ind <= 0;
state <= Stop;
baud_rate <= 0;
end
else begin
data_out[bit_ind] <= rx;
bit_ind <= bit_ind + 1;
baud_rate <= 0;
end
end
else baud_rate <= baud_rate + 1;
end

Stop: begin
if(baud_rate == 5207) begin
if(rx == 1) begin
state <= Idle;
done <= 1;
baud_rate <= 0;
end
else begin
state <= Idle;
done <= 0;
baud_rate <= 0;
end

end
else baud_rate <= baud_rate + 1;
end
endcase

end

end

endmodule
