module m_mir(
input clk,rst,
//clk: Señal de reloj del sistema.
//rst: Señal de rst del sistema.
input [40:0] in_mir,// Microinstrucción de entrada que proviene directamente de la control store.
output reg [40:0] out_mir// Microinstrucción de salida hacia el resto del sistema.
);



parameter Reset=0; 	//Estado de reset del registro.
parameter [40:0] Refresh=1;	// Estado de espera del registro.

parameter rst_mir=41'b10000001000000100101010010100000000000000;// Microinstrucción '0' de la control store.

reg rState,sState;	//Variables de estado: Estado actual y siguiente respectivamente.


initial 
begin
	rState<=Reset;
	out_mir=41'b10000001000000100101010010100000000000000;
end
// state register
	always@(posedge clk, posedge rst)
	if (rst) rState <= Reset;
	else rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	Reset:sState=Refresh;
	Refresh:sState=Refresh; 

	default: sState = Reset;
	endcase

// output logic
	always@(negedge clk)
	case(rState)
	Reset:begin out_mir<=rst_mir; end
	Refresh:begin out_mir<=in_mir;end

	default:begin out_mir<=rst_mir;end
	endcase

endmodule
