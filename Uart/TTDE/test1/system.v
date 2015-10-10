
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
	input		clk, rst, wr,rd, 
	input   [7:0]   denv,
	output	[7:0]	drec

);
/*Declaración de cables*/

	wire [7:0] w_wdata,w_rdata,w_edata;	

/*Decaración demódulos*/

	/*Control section: Esté módulo cnntrola la operación del datapath. 
	Contiene toda la lógica que permite decidir 
        los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory.*/

	uart uart_echo(
    	.clk(clk), 
	.reset(rst),
    	.rd_uart(~w_empty),
	.wr_uart(~w_empty), 
	.rx(rx),
    	.w_data(w_data), 
    	.tx_full(), 
	.rx_empty(w_empty), 
	.tx(tx),
    	.r_data(w_edata)
	);

	uart uart_master(
    	.clk(clk), 
	.reset(rst),
    	.rd_uart(rd),
	.wr_uart(1'b0), 
	.rx(w_tr),
    	.w_data(w_wdata),
    	.tx_full(), 
	.rx_empty(), 
	.tx(w_rc),
    	.r_data(w_rdata) //TODO: DECLARAR CABLE
	);

assign drec=w_rdata;
assign w_wdata=denv;


endmodule
