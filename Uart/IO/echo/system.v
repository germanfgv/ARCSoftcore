	
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
	//input wr,rd, habilitarDecodificador, 
	input selectorMuxIO, selectorMuxMMIO,selectorMuxALUCC,
	//input    [4:0]   entradaDecodificador,
	///input   [7:0]   denv, data_IO, dataBMM,
	//input    [15:0]  dataMuxIO,
	//output   [15:0]  salidaMemoriaR,
	//output   [7:0]	drec
    output     [1:0] dataOutALU_REGEN

);
/*Declaración de cables*/

	//wire [7:0] w_wdata,w_rdata,w_edata;	
	wire [1:0] dataOutMuxIO,dataOutMM_IO;

/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/
/*
	uart uart_echo(
    	.clk(clk), 
		.reset(rst),
    	.rd_uart(~w_empty),
		.wr_uart(~w_empty), 
		.rx(w_rc),
    	.w_data(w_edata), 
    	.tx_full(), 
		.rx_empty(w_empty), 
		.tx(w_tr),
    	.r_data(w_edata)
	);

	uart uart_master(
    	.clk(clk), 
		.reset(rst),
    	.rd_uart(rd),
		.wr_uart(wr), 
		.rx(w_tr),
    	.w_data(w_wdata),
    	.tx_full(), 
		.rx_empty(), 
		.tx(w_rc),
    	.r_data(w_rdata)
	);

	IO_mem IO_Memory_Block (
		.clk(clk),
		.rst(rst),
		.data_IO_in(data_IO),
		.habilitar(habilitarDecodificador),
		.entradaDeco(entradaDecodificador),
		.salidaMemoria(salidaMemoriaR)
	);

	*/

	multiplexor #(.T(2)) muxer_IOmem (
		.selection(selectorMuxIO),
		.datain({2'b00,2'b01}),
		.dataout(dataOutMuxIO)
		);

	multiplexor #(.T(2)) muxer_MM_IO(
		.selection(selectorMuxMMIO),
		.datain({dataOutMuxIO,2'b10}),
		.dataout(dataOutMM_IO)
		);

	multiplexor #(.T(2)) muxer_ALU_CC (
		.selection(selectorMuxALUCC),
		.datain({dataOutMM_IO,2'b11}),
		.dataout(dataOutALU_REGEN)
		);
//assign drec=w_rdata;
//assign w_wdata=denv;


endmodule
