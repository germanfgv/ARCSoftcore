
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
	input		clk, rst, w_write,w_read, 
	input   [7:0]   denv,
	output	[7:0]	drec

);
/*Declaración de cables*/

	wire [7:0] w_wdata,w_rdata;	

/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/

	uart uart_tr(
    	.clk(clk), 
	.reset(rst),
    	.rd_uart(1'b0),
	.wr_uart(w_write), 
	.rx(w_rc),
    	.w_data(w_wdata), //TODO: DECLARAR CABLE, ya no :3 
    	.tx_full(), 
	.rx_empty(), 
	.tx(w_tr),
    	.r_data()
	);

	uart uart_rc(
    	.clk(clk), 
	.reset(rst),
    	.rd_uart(w_read),
	.wr_uart(1'b0), 
	.rx(w_tr),
    	.w_data(),
    	.tx_full(), 
	.rx_empty(), 
	.tx(w_rc),
    	.r_data(w_rdata) //TODO: DECLARAR CABLE
	);

assign w_wdata=denv;
assign w_rdata=drec;


endmodule