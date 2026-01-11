module UART_trans(clk,rst,data_in,tx,done,tx_start);
input clk,rst,tx_start;
input [7:0]data_in;
output reg tx,done;

parameter Idle = 2'b00, Start = 2'b01, Data = 2'b10, Stop = 2'b11;

reg [1:0]state;
reg [7:0]saved_data;
reg [3:0]bit_ind;
reg [12:0]baud_rate;
wire tick;

assign tick = (baud_rate == 5207);

always @(posedge clk) begin
if(state == Idle) baud_rate <= 0;
else if(baud_rate == 5207) baud_rate <= 0;
else baud_rate <= baud_rate + 1;
end

always @(posedge clk or negedge rst) begin
if(!rst) begin
state <= Idle;
done <= 0;
tx <= 1;
bit_ind <= 0;
end

else begin

case(state)

Idle: begin
tx <= 1;
done <= 0;
if(!tx_start) begin
state <= Start;
done <= 0;
tx <= 0;
bit_ind <= 0;
saved_data <= data_in;
end
end

Start: begin
tx <= 0;
done <= 0;
if(tick) state <= Data;
end

Data: begin
tx <= saved_data[bit_ind];
if(tick) begin
if(bit_ind == 7) begin
state <= Stop;
bit_ind <= 0;
end
else bit_ind <= bit_ind + 1;
end
end

Stop: begin
tx <= 1;
done <= 1;
if(tick) state <= Idle;
end
endcase 

end
end

endmodule



















