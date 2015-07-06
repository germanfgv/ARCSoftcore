module csai(
input ack,rst,
input [10:0] actual_addr,
output reg [10:0] next_addr
);

always@(negedge ack,posedge rst)
	
next_addr = rst ? 0:actual_addr+1;

endmodule
