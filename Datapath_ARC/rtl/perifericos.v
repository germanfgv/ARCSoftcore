	
// SharkBoad SystemModule
//
// Top Level Design for the Xilinx Spartan 3-100E Device
//---------------------------------------------------------------------------

/*#
# SharkBoad
# Copyright (C) 2012 Bogotá, Colombia
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# Hoy me siento un poco triste, hay cosas de mi vida que aún están sin sanar y duelen
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#*/

module perifericos
#(parameter	clk_freq	= 50000000) 
(
	input			clk, rst, 
	input       	wr,rd, rx,
	input       	s_io,s_mmio,
	input	[7:0]	data_in,
    output      	tx, 
    output [7:0] 	data_out,
    output reloj

);
/*Declaración de cables*/
	wire [7:0] dataOutMuxIO,dataOutMM_IO, dataUART;
	wire stateTX,stateRX;
	wire debRd, debWr;

/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/

	uart uart_master(
    	.clk(clk), 
		.reset(rst),
    	.rd_uart(debRd),
		.wr_uart(debWr), 
		.rx(rx),
    	.w_data(data_in),
    	.tx_full(stateTX), 
		.rx_empty(stateRX), 
		.tx(tx),
    	.r_data(dataUART)
	);

	multiplexor8b  muxer_IOmem (
		.selection(s_io),
		.datain({dataUART,{6'b000000,stateTX,stateRX}}),
		.dataout(data_out)
		);



	debounce debRD(
		.clk(clk), .reset(rst), .sw(w_rd_db), .db_tick(debRd), .db_level()
	);

	debounce debWR(
		.clk(clk), .reset(rst), .sw(w_wr_db), .db_tick(debWr), .db_level()
	);

	assign w_rd_db = ~(rd && s_mmio);
	assign w_wr_db = (wr && s_mmio);

endmodule
