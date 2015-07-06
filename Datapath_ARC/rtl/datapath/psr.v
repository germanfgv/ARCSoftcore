//Processor Status Register: Este módulo es el encargado de almacenar las banderas y mostrar su actualización o no dependiendo de las operaciones realizadas en la ALU.
module psr(
input ccsignal,n,z,v,c,clk,rst, 
// ccsignal: Bit más significativo de la instrucción de la ALU.
// n: Bandera 'negativo' de la ALU.
// z: Bandera 'cero' de la ALU.
// v: Bandera 'overflow'de la ALU.
// c: Bandera 'carry'de la ALU.
//clk: Señal de reloj de sistema. 
//rst: Señal de reset del sistema.
output reg nout,zout,vout,cout
// nout: Bandera 'negativo' actualizada según las condiciones de ccsignal.
// zout: Bandera 'cero' actualizada según las condiciones de ccsignal.
// vout: Bandera 'overflow' actualizada según las condiciones de ccsignal.
// cout: Bandera 'carry' actualizada según las condiciones de ccsignal.

);

parameter [1:0] Reset=2'b00; //Estado de reset del registro
parameter [1:0] Wait=2'b01;// Estado de espera del registro
parameter [1:0] Refresh=2'b10;// Estado de actualización del registro

reg [1:0] rState,sState;//Variables de estado: Estado actual y siguiente respectivamente


// state register
	always@(posedge clk, posedge rst)
	if (rst) rState <= Reset;
	else rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	Reset: sState= (!rst) ? Wait:Reset ;
	Wait:begin sState= (rst) ? Reset:(!ccsignal) ? Refresh: Wait; end
	Refresh:begin sState= rst ? Reset : ccsignal ? Wait : Refresh; end

	default: sState = Reset;
	endcase

// output logic
	always@(negedge clk)
	case(rState)
	Reset:begin nout<=0;vout<=0;zout<=0;cout<=0;end
	Wait:begin nout<=nout;vout<=vout;zout<=zout;cout<=cout;end
	Refresh:begin nout<=n;vout<=v;zout<=z;cout<=c;end

	default:begin nout<=nout;vout<=vout;zout<=zout;cout<=cout;end
	endcase

endmodule
