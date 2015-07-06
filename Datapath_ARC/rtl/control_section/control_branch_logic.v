module control_branch_logic(
input ir13,//Bit 13 del Instruction Register.
input [3:0] psr,//Señal del Process Status Register.Aquel que contiene las banderas.
input [2:0] cond,//Señal de condicionamiento de la microinstrucción actual.
output reg [1:0] out//Instrucción de escogencia para el CSaddressmux(mux_csa).
);

//Declaración de parametros.
parameter Next=2'b00;
parameter Jump=2'b01;
parameter Dec=2'b10;

wire n,z,v,c;

assign {n,z,v,c} = psr; //Separación de las flags que se encuentran en el psr.

//Lógica de salto. Se calcula la instrucción que recibirá el CSaddressmux(mux_csa) para la escogencia de la proxima microinstrucción a ejecutar.
always@(*)
	begin
		case(cond)
		0:out=Next; //Use NEXT ADDR

		1:if(n==1)
			out=Jump;//Use JUMP ADDR if n = 1
		else
			out=Next;

		2:if(z==1)
			out=Jump;//Use JUMP ADDR if z = 1
		else
			out=Next;

		3:if(v==1)
			out=Jump;//Use JUMP ADDR if v = 1
		else
			out=Next;

		4:if(c==1)
			out=Jump;//Use JUMP ADDR if c = 1
		else
			out=Next;

		5:if(ir13==1)
			out=Jump;//Use JUMP ADDR if IR[13] = 1
		else
			out=Next;

		6:out=Jump;//Use JUMP ADDR
		
		7:out=Dec;//Decode
		endcase
	end
endmodule
