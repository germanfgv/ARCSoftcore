module multiplexor #(
parameter N=4, //Número de señales de entrada
parameter M=8, //Número de bits sseñal de entrada
parameter P=2  //Número de bits de la señal de selección
)
(
input [P-1:0]selection,//Señal de selección para la escogencia del registro de salida.
input[M*N-1:0] datain,//Bus de datos de entrada.
output [M-1:0] dataout//Datos escogidos.
);

wire [31:0] temp;//Variable temporal de almacenamiento en la cual se efectua el corrimiento para escoger los datos deseados

//Operación de selección.
assign temp= datain>>(M*selection);
assign dataout= temp;

endmodule



