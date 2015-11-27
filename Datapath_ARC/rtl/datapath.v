module datapath #(
parameter R=16 //Número de registros de proposito general
)
(
input clk,rst,
input [40:0] mir,
input [31:0] data_MM, // Datos de la Main Memory que puede ingresar al bus C para que sean escritos en los registros
output [31:0]	w_ir,
		busA,
		busB,
output [7:0] data,
output [3:0] w_psr
);


/* 
Declaración de cables
*/
wire [5:0]	w_mux_a,   //Cable que conecta el multiplex A con el decoder A
		w_mux_b,   //Cable que conecta el multiplex B con el decoder B
		w_dec_c;   //Cable que conecta el multiplex C con el decoder C

wire [3:0]	w_flags;     //Vector de flags de la ALU


wire [31:0]	w_bus_a,
		w_data_alu,
		w_data_shifter,
		w_bus_b,
		w_bus_c;     //Bus usado para escribir en los registros



wire [37:0]		w_writer;  //Señal de escritura para los registros


wire [(32*(R+6)-1):0] 	w_data_reg; //Bus que concatena la salida de todos los registros

wire [31:0]		w_data_ir;  //Datos del Instruction register	 

wire [4:0]		w_auxiliar_a,
			w_auxiliar_b; 

//Asignaciones combinacionales

assign w_data_reg[(R+6)*32-1:(R+5)*32]=w_data_ir;
assign w_ir=w_data_ir;
assign busA = w_bus_a;
assign busB = w_bus_b;

/* Declaración de registros
*/

	//Registro 0. Siempre contiene el valor 0. No es modificable
assign w_data_reg[31:0] = 0;
	
	
	//Generación de los registros visibles al usuario

	registro reg_1(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[1]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(2)-1:32*(1)])
		);

	registro reg_2(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[2]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(3)-1:32*(2)])
		);

	registro reg_3(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[3]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(4)-1:32*(3)])
		);

	registro reg_4(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[4]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(5)-1:32*(4)])
		);

	registro reg_5(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[5]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(6)-1:32*(5)])
		);

	registro reg_6(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[6]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(7)-1:32*(6)])
		);

	registro reg_7(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[7]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(8)-1:32*(7)])
		);

	registro reg_8(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[8]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(9)-1:32*(8)])
		);

	registro reg_9(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[9]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(10)-1:32*(9)])
		);

	registro reg_10(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[10]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(11)-1:32*(10)])
		);

	registro reg_11(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[11]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(12)-1:32*(11)])
		);

	registro reg_12(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[12]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(13)-1:32*(12)])
		);

	registro reg_13(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[13]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(14)-1:32*(13)])
		);

	registro reg_14(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[14]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(15)-1:32*(14)])
		);

	registro reg_15(
		.rst(rst),			
		.clk(clk),
		.writer(w_writer[15]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(16)-1:32*(15)])
		);

//	registro reg_16(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[16]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(17)-1:32*(16)])
//		);

//	registro reg_17(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[17]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(18)-1:32*(17)])
//		);

//	registro reg_18(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[18]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(19)-1:32*(18)])
//		);

//	registro reg_19(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[19]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(20)-1:32*(19)])
//		);

//	registro reg_20(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[20]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(21)-1:32*(20)])
//		);

//	registro reg_21(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[21]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(22)-1:32*(21)])
//		);

//	registro reg_22(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[22]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(23)-1:32*(22)])
//		);

//	registro reg_23(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[23]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(24)-1:32*(23)])
//		);

//	registro reg_24(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[24]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(25)-1:32*(24)])
//		);

//	registro reg_25(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[25]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(26)-1:32*(25)])
//		);

//	registro reg_26(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[26]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(27)-1:32*(26)])
//		);

//	registro reg_27(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[27]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(28)-1:32*(27)])
//		);

//	registro reg_28(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[28]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(29)-1:32*(28)])
//		);

//	registro reg_29(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[29]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(30)-1:32*(29)])
//		);

//	registro reg_30(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[30]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(31)-1:32*(30)])
//		);

//	registro reg_31(
//		.rst(rst),			
//		.clk(clk),
//		.writer(w_writer[31]),
//		.datain(w_bus_c),
//		.dataout(w_data_reg[32*(32)-1:32*(31)])
//		);


//	genvar i;
//	generate for ( i= 1; i <= 31; i = i+1 )
//		begin: reg_i
//		registro reg_i(
//			.rst(rst),			
//			.clk(clk),
//			.writer(w_writer[i]),
//			.datain(w_bus_c),
//			.dataout(w_data_reg[32*(i+1)-1:32*i])
//			);
//	end
//	endgenerate
	
	//Program counter
	
	registro pc(
		.rst(rst),
		.clk(clk),
		.writer(w_writer[R+16]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(R+1)-1:32*(R)])
		);
	
	
	//Registros temporales
	

	registro temp_0(
		.rst(rst),
		.clk(clk),
		.writer(w_writer[R+1+16]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(R+2)-1:32*(R+1)])
		);

	registro temp_1(
		.rst(rst),
		.clk(clk),
		.writer(w_writer[R+2+16]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(R+3)-1:32*(R+2)])
		);


	registro temp_2(
		.rst(rst),
		.clk(clk),
		.writer(w_writer[R+3+16]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(R+4)-1:32*(R+3)])
		);


	registro temp_3(
		.rst(rst),
		.clk(clk),
		.writer(w_writer[R+4+16]),
		.datain(w_bus_c),
		.dataout(w_data_reg[32*(R+5)-1:32*(R+4)])
		);



//	genvar j;
//	generate for ( j= 0; j <= 3; j = j+1 )
//		begin: temp_j
//		registro temp_j(
//			.rst(rst),
//			.clk(clk),
//			.writer(w_writer[j+33]),
//			.datain(w_bus_c),
//			.dataout(w_data_reg[32*(j+34)-1:32*(j+33)])
//			);
//	end
//	endgenerate
	
	
	//Instruction registrer
	
	registro ir(
		.rst(rst),	
		.clk(clk),
		.writer(w_writer[R+5+16]),
		.datain(w_bus_c),
		.dataout(w_data_ir)
		);
	
	
	
/* Declaración de multiplexores
*/
	
	//Multiplexores de Señal de Selección: Multiplexan las señales de selección de registro (la señal de 'ir' o 		la del 'mir') que llegará a los multiplexores de selección de registro de los buses A y B, o al    		decodificardor 	del bus C
	mux_instruction_selector #(.M(6)) mux_is_a(
		.selection(mir[34]),
		.data_0(mir[40:35]),//campo BusA del microcode instruction regster
		.data_1(w_data_ir[18:14]), //campo rs1 del instruction register
		.z(w_mux_a)
	);


	mux_instruction_selector #(.M(6)) mux_is_b(
		.selection(mir[27]),
		.data_0(mir[33:28]),
		.data_1(w_data_ir[4:0]), //campo rs2 del intruction register
		.z(w_mux_b)
	);


	mux_instruction_selector #(.M(6)) mux_is_c(
		.selection(mir[20]),
		.data_0(mir[26:21]),
		.data_1(w_data_ir[29:25]), //campo rd del intruction register
		.z(w_dec_c)
	);
	
	assign w_auxiliar_a = (w_mux_a<16) ? w_mux_a : w_mux_a-6'b010000;
	

	assign w_auxiliar_b = (w_mux_b<16) ? w_mux_b : w_mux_b-6'b010000;



	//multiplexores de selección de registro: Multiplexan los valores de los registros para escoger los datos que 	iran a los buses A y B

	multiplexor #(
		.N(22), //Número de señales de entrada
		.M(32), //Número de bits señal de entrada
		.P(5)   //Número de bits de la señal de selección
		)
	selectionA(
		.selection(w_auxiliar_a),
		.datain(w_data_reg),
		.dataout(w_bus_a)
		);

	multiplexor #(
		.N(22), //Número de señales de entrada
		.M(32), //Número de bits señal de entrada
		.P(5)   //Número de bits de la señal de selección
		)
	selectionB(
		.selection(w_auxiliar_b),
		.datain(w_data_reg),
		.dataout(w_bus_b)
		);

	multiplexor #(
		.N(2), //Número de señales de entrada
		.M(32), //Número de bits señal de entrada
		.P(1)   //Número de bits de la señal de selección
		)
	selectionC(
		.selection(mir[19]),
		.datain({data_MM,w_data_shifter}),
		.dataout(w_bus_c)
		);
/* Declaración de decoders

Este módulo envia la señal que habilita la escritura de los datos del bus C en los registros
*/


	decoder dec_c(
		.seleccion(w_dec_c),
		.habilitador(w_writer)
		);


/* Declaración de la ALU
Unidad encargada de realizar las operaciones aritméticas y lógicas que sean requeridas
*/
	alu alu_1(
		.busA(w_bus_a),
		.busB(w_bus_b),// Entradas de 32 bits de los buses "A" y "B" .
		.func(mir[17:14]),// Bits de selección de función de la ALU.
		.busC(w_data_alu),// Salida de 32 bits para el busC.
		.psr(w_flags)// Bits para banderas de Carry, Negative, Overflow, Zero.
		);

/* Declaración del psr
Módulo que actualiza las banderas en el vector psr 
*/
	psr psr(
		.clk(clk),
		.rst(rst),
		.ccsignal(mir[17]|mir[16]),
		.n(w_flags[3]),
		.z(w_flags[2]),
		.v(w_flags[1]),
		.c(w_flags[0]),
		.nout(w_psr[3]),
		.zout(w_psr[2]),
		.vout(w_psr[1]),
		.cout(w_psr[0])
		);
/*Declaración del Barrel Shifter
Módulo que desplaza bits de aquel registro presente en el bus A
*/
	shifter shift(
	.data_alu(w_data_alu),
	.bus_b(w_bus_b[4:0]),
	.func(mir[17:14]),
	.z(w_data_shifter)

	);

assign data=w_data_reg[32*(3)+7:32*(3)];

endmodule
