module multiplexor #(
parameter R=2, //Número de señales de entrada
parameter T=8, //Número de bits sseñal de entrada
parameter N=1  //Número de bits dedicados para la selección de registros I/O TODO: Log2(N) Aproximar hacia arriba, por lo menos. 
)
(
input [N-1:0] selection,//Señal de selección para la escogencia del registro de salida.
input[R*T-1:0] datain,//Bus de datos de entrada. //TODO: Conectar siempre en orden desde 1 hasta la cantidad de registros totales. Así al seleccionar 1 se selecciona el registro 1 y así sucesivamente.
output reg [T-1:0] dataout//Datos escogidos.
);


//Operación de selección

always @(*) 
	begin
		case(selection)
			0: dataout=datain[7:0];
			1: dataout=datain[15:8];
			default dataout=0;
		endcase
	end
endmodule