	
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

module system
#(parameter	clk_freq	= 50000000) 
(
	input		clk, rst, 
	input       wr,rd, rx,
	input       selectorMuxIO, selectorMuxMMIO,selectorMuxALUCC,
    output      tx

);
/*Declaración de cables*/
	wire [7:0] dataOutMuxIO,dataOutMM_IO, dataUART;
	wire stateTX,stateRX;

/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/

	uart uart_master(
    	.clk(clk), 
		.reset(w_rst),
    	.rd_uart(rd),
		.wr_uart(wr), 
		.rx(rx),
    	.w_data(dataOutALU_REGEN),
    	.tx_full(stateTX), 
		.rx_empty(stateRX), 
		.tx(tx),
    	.r_data(dataUART)
	);

	multiplexor  muxer_IOmem (
		.selection(selectorMuxIO),
		.datain({dataUART,{6'b000000,stateTX,stateRX}}),
		.dataout(dataOutMuxIO)
		);

	multiplexor muxer_MM_IO(
		.selection(selectorMuxMMIO),
		.datain({dataOutMuxIO,8'b01010010}),
		.dataout(dataOutMM_IO)
		);

	multiplexor muxer_ALU_CC (
		.selection(selectorMuxALUCC),
		.datain({dataOutMM_IO,8'b01011000}),
		.dataout(dataOutALU_REGEN)
		);

assign  w_rst = ~rst;
endmodule
