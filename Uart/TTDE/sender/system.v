
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
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#*/

module system
#(parameter	clk_freq	= 50000000) 
(
	input		clk, rst, rx,
	output		tx,full, empty_rx, data_out


);
/*Declaración de cables*/

wire [7:0]  rx_data;
 
/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/

	uart uart_kindred(
	    	.clk(clk), 
		.reset(rst),
	    	.rd_uart(1'b0),
		.wr_uart(1'b1), 
		.rx(rx),
	    	.w_data(85), 
	    	.tx_full(full), 
		.rx_empty(empty_rx), 
		.tx(tx),
	    	.r_data(rx_data)
	);

assign data_out= |rx_data;


endmodule
