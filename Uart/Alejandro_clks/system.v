
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
clk          ,
//resetclk,
//ld_tx_data     ,
//tx_data        ,
//tx_enable      ,
tx_out         ,
//tx_empty       ,
//uld_rx_data    ,
//rx_data        ,
//rx_enable      ,
rx_in          ,
rx_empty,
tx_clk,
rx_clk
);
// Port declarations
input        reset          ;
//input 		resetclk;
input        clk          ;
//input        ld_tx_data     ;
//input  [7:0] tx_data        ;
//input        tx_enable      ;
output       tx_out         ;
//output       tx_empty       ;
//input        rxclk          ;
//input        uld_rx_data    ;
//output [7:0] rx_data        ;
//input        rx_enable      ;
input        rx_in          ;
output       rx_empty       ;
output 			tx_clk;
output			rx_clk;

  

wire tx;
wire empty_uload;
wire tx_clk;
wire rx_clk;

wire nreset = ~reset;

wire [7:0] data;

/*Decaración de módulos*/

	//UART a probar 
	uart uart_1(
	.reset(nreset)       		   ,
	.txclk(tx_clk)        	  	   ,
	.ld_tx_data(1)        ,
	.tx_data(data)              ,
	.tx_enable(1)          ,
	.tx_out(tx_out)                    ,
	.tx_empty(empty_uload)            ,
	.rxclk(rx_clk)          		   ,
	.uld_rx_data(empty_uload)      ,
	.rx_data(data)        	   ,
	.rx_enable(1)          ,
	.rx_in(rx_in)          		   ,
	.rx_empty(rx_empty)
	);


	counter #(	.N(32),
				.M(50000000/(9600)) 
			)
		counter_tx
		(
    	.clk(clk), .reset(nreset),
    	.max_tick(tx_clk)
   		);

	counter #(	.N(32),
				.M(50000000/(16*9600)) 
			)
		counter_rx
		(
    	.clk(clk), .reset(nreset),
    	.max_tick(rx_clk)
   		);


endmodule
