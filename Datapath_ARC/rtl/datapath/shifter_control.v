/* 
Este módulo controla el funcionamiento del shifteador
*/

module shifter_control 
(
	input [3:0]	func, //funcion que está realizado a ALU
	input [4:0]	bus_b, //Cantidad de bits para shiftear en SRL
	output reg	shift_right, // '1' si el shift es hacia la derecha, '0' si es hacia la izquerda
	output reg[4:0] sa //Shift Amount
);

always@(*)
begin
	case(func)
	4: 	 begin shift_right=1'b1; sa=bus_b; end// SRL
	9: 	 begin shift_right=1'b0; sa=2; end// LSHIFT2
	10:	 begin shift_right=1'b0; sa=10; end// LSHIFT10
	default: begin shift_right=1'b0; sa=0; end// No Shift
	endcase
end

endmodule

