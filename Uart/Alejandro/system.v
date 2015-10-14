
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
reset          ,
txclk          ,
ld_tx_data     ,
tx_data        ,
tx_enable      ,
tx_out         ,
tx_empty       ,
rxclk          ,
uld_rx_data    ,
rx_data        ,
rx_enable      ,
rx_in          ,
rx_empty
);
// Port declarations
input        reset          ;
input        txclk          ;
input        ld_tx_data     ;
input  [7:0] tx_data        ;
input        tx_enable      ;
output       tx_out         ;
output       tx_empty       ;
input        rxclk          ;
input        uld_rx_data    ;
output [7:0] rx_data        ;
input        rx_enable      ;
input        rx_in          ;
output       rx_empty       ;

/*

wire [31:0] w_ir;// Instructión register
wire [40:0] w_mir;// Vicrocode instruction register
wire [3:0]  w_psr;// Vector que contiene los Condition Codes (flags)
wire [31:0] w_data_mm,// bus que lleva datos de la Main memory al datpath
	    w_bus_a,//Bus A del datapath que sirve como address de la MM
	    w_bus_b;//Bus B del datapath en el que se envian datos a la MM
*/	  

wire tx;
wire empty_uload;

/*Decaración demódulos*/

	//UART a probar 
	uart uart_1(
	.reset(reset)       		   ,
	.txclk(txclk)        	  	   ,
	.ld_tx_data(ld_tx_data)        ,
	.tx_data(tx_data)              ,
	.tx_enable(tx_enable)          ,
	.tx_out(tx)                    ,
	.tx_empty(empty_uload)            ,
	.rxclk(rxclk)          		   ,
	.uld_rx_data(uld_rx_data)      ,
	.rx_data(rx_data)        	   ,
	.rx_enable(rx_enable)          ,
	.rx_in(rx_in)          		   ,
	.rx_empty(rx_empty)
	);

	uart uart_2(
	.reset(reset)       		   ,
	.txclk(txclk)        	  	   ,
	.ld_tx_data(ld_tx_data)        ,
	.tx_data(tx_data)              ,
	.tx_enable(tx_enable)          ,
	.tx_out(tx_out)                ,
	.tx_empty(tx_empty)            ,
	.rxclk(rxclk)          		   ,
	.uld_rx_data(empty_uload)      ,
	.rx_data(rx_data)        	   ,
	.rx_enable(rx_enable)          ,
	.rx_in(tx)          		   ,
	.rx_empty(rx_empty)
	);



endmodule
