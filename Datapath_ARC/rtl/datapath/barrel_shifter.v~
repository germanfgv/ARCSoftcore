		module barrel_shifter
(
	input [31:0]	data_alu, 	//Entradas.
	input 		shift_right,		// 1 si el shift es hacia la derecha, 0 si es hacia la izquerda.
	input [4:0]	sa, 	// Shift Amount
	output [31:0]	z 		// Salida del Shifter
);

wire [31:0] temp_1,temp_2,temp_3,temp_4,temp_5,temp_6,temp_7,temp_8,temp_9,temp_10;


assign temp_1=data_alu<<(16*sa[4]);
assign temp_2=temp_1<<(8*sa[3]);
assign temp_3=temp_2<<(4*sa[2]);
assign temp_4=temp_3<<(2*sa[1]);
assign temp_5=temp_4<<(sa[0]);

assign temp_6=data_alu>>(16*sa[4]);
assign temp_7=temp_6>>(8*sa[3]);
assign temp_8=temp_7>>(4*sa[2]);
assign temp_9=temp_8>>(2*sa[1]);
assign temp_10=temp_9>>(sa[0]);



assign	z= (shift_right==1) ? temp_10 : temp_5;  

endmodule



