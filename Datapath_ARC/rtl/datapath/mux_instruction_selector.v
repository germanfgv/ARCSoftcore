module mux_instruction_selector #(
	parameter M=6,//Multiplex's Number of bits
	parameter N=1//Number of bits in 'selection'
)


(
input [N-1:0]selection,
input [M-2:0] data_1, 
input [M-1:0] data_0,
output [M-1:0] z
);

assign z=(selection==1)? data_1:data_0;

endmodule
