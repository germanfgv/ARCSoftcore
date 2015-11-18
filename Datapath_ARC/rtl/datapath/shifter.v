module shifter
(
	input[31:0]	data_alu,
	input[4:0]	bus_b,
	input[3:0]	func,
	output [31:0]z	
);

wire [4:0] w_sa;
wire w_shift_right;

shifter_control sc(
.func(func),
.bus_b(bus_b[4:0]),
.shift_right(w_shift_right),
.sa(w_sa)
);

barrel_shifter bs(
.data_alu(data_alu),
.shift_right(w_shift_right),
.sa(w_sa),
.z(z)
);

endmodule
