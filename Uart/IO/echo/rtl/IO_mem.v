module IO_mem #
(
 parameter R=2, // Cantidad de registros de propósito general dedicaddos para I/O 
 parameter N=5, // Número de bits dedicados para la selección de registros I/O TODO: Log2(R) Aproximar hacia arriba. 
 parameter T=8  // Tamaño de los registros 
)

	(
	input habilitar, rst, clk, 
	input [N-1:0] entradaDeco,
	input [T-1:0] data_IO_in,
	output [(R*T)-1:0] salidaMemoria
	);

reg [N-1:0] base=1;
wire [N-1:0] salidaDeco;
//reg [N-1:0] salidaDeco=0;
assign salidaDeco=habilitar*(base<<(entradaDeco));

	registro reg_1(
		.rst(rst),			
		.clk(clk),
		.writer(salidaDeco[0]),       //TODO: A mano, modificar el bit write que nos permite editar este registro 
		.datain(data_IO_in),
		.dataout(salidaMemoria[7:0])  //TODO: A mano, modificar los bits de salida en grupos de 8 bits
		);


	registro reg_2(
		.rst(rst),			
		.clk(clk),
		.writer(salidaDeco[1]),       //TODO: A mano, modificar el bit write que nos permite editar este registro 
		.datain(data_IO_in),
		.dataout(salidaMemoria[15:8]) //TODO: A mano, modificar los bits de salida en grupos de 8 bits
		);



endmodule
