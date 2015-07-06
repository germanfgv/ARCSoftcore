/*Multiplexor estandar de 4 a 1.
*/
module mux_csa(
input [10:0] in_a, in_b, in_c,in_d,//Entradas de las cuales se va a seleccionar el dato de salida.
input [1:0]  select,//Señal de selección.
output [10:0] out//Dato escogido.
);

assign out=(select==2'b00)?in_a:(select==2'b01)?in_b:(select==2'b10)?in_c:in_d;

endmodule
