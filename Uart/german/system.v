
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
	input		clk, rst,ack,
	output	[3:0]	data

);
/*Declaración de cables*/
wire [31:0] w_ir;// Instructión register
wire [40:0] w_mir;// Vicrocode instruction register
wire [3:0]  w_psr;// Vector que contiene los Condition Codes (flags)
wire [31:0] w_data_mm,// bus que lleva datos de la Main memory al datpath
	    w_bus_a,//Bus A del datapath que sirve como address de la MM
	    w_bus_b;//Bus B del datapath en el que se envian datos a la MM


/*Decaración demódulos*/

	//Control section: Esté módulo cnntrola la operación del datapath. Contiene toda la lógica que permite decidir 		los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory. 
	uart uart_tr(
	.rst(rst),
	.clk(clk),
	.ack(ack),
	.ir(w_ir),
	.w_psr(w_psr),
	.mir(w_mir)
	);




assign data=w_psr;
endmodule
