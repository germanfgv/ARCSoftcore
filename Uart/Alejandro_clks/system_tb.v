//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------

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

`timescale 1 ns / 100 ps

module system_tb;

//----------------------------------------------------------------------------
// Parameter (may differ for physical synthesis)
//----------------------------------------------------------------------------
parameter tck              = 20;       // clock period in ns
parameter clk_freq = 1000000000 / tck; // Frequenzy in HZ
//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
reg clk_tb;

reg reset_tb;  

reg resetclk_tb;


//reg txclk_tb;          
reg ld_tx_data_tb;  
reg [7:0] tx_data_tb;        
reg tx_enable_tb;      
wire tx_out_tb;         
wire tx_empty_tb;       
//reg rxclk_tb; 
reg uld_rx_data_tb;
wire [7:0] rx_data_tb;
reg rx_enable_tb;
reg rx_in_tb;     
wire rx_empty_tb;

//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------
system #(
	.clk_freq	(	clk_freq	)
) 

dut  (
	.reset(reset_tb)       		   ,
	.clk(clk_tb)        	  	   ,
//	.resetclk(resetclk_tb)		   ,
//	.ld_tx_data(ld_tx_data_tb)        ,
//	.tx_data(tx_data_tb)              ,
//  .tx_enable(tx_enable_tb)          ,
	.tx_out(tx_out_tb)                ,
//	.tx_empty(tx_empty_tb)            ,
//	.rxclk(rxclk_tb)          		   ,
//	.uld_rx_data(uld_rx_data_tb)      ,
//	.rx_data(rx_data_tb)        	   ,
//	.rx_enable(rx_enable_tb)          ,
	.rx_in(rx_in_tb)          		   ,
	.rx_empty(rx_empty_tb)
	
);


/* Clocking device */
// Remember this is only for simulation. It never will be syntetizable //
initial begin        
		clk_tb <= 0;
		//txclk_tb <= 0;
		//rxclk_tb <= 0;
end

always #(tck/2) clk_tb <= ~clk_tb;
//always #(tck/2) rxclk_tb <= ~rxclk_tb;


/* Simulation setup */
initial begin
	//set the file for loggin simulation data
	$dumpfile("system_tb.vcd"); 
	//$monitor("%b,%b,%b",clk_tb,rst_tb,led_tb);
	//export all signals in the simulation viewer
	$dumpvars(-1, dut);
	//$dumpvars(-1,clk_tb,rst_tb,led_tb, dut);
	
	//$dumpvars(-1,clk_tb,rst_tb);

	/*
	#0  reset_tb <= 0;
	#0 ld_tx_data_tb <= 0;
	#0 tx_data_tb <= 0;
	#0 tx_enable_tb <= 0;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 0;
	#0 rx_in_tb <= 1;

	#10

	#0  reset_tb <= 1;
	#0 ld_tx_data_tb <= 0;
	#0 tx_data_tb <= 8'b10101010;
	#0 tx_enable_tb <= 0;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 0;
	#0 rx_in_tb <= 1;

	#70000
	
	#0  reset_tb <= 0;
	#0 ld_tx_data_tb <= 1;
	#0 tx_data_tb <= 8'b11101111;
	#0 tx_enable_tb <= 0;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 0;
	#0 rx_in_tb <= 1;

	#70000
	
	#0  reset_tb <= 0;
	#0 ld_tx_data_tb <= 0;
	#0 tx_data_tb <= 8'b11101111;
	#0 tx_enable_tb <= 1;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 1;
	#0 rx_in_tb <= 1;

	#70000
	
	#0  reset_tb <= 0;
	#0 ld_tx_data_tb <= 1;
	#0 tx_data_tb <= 8'b11110010;
	#0 tx_enable_tb <= 0;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 0;
	#0 rx_in_tb <= 1;

	#70000
	
	#0  reset_tb <= 0;
	#0 ld_tx_data_tb <= 0;
	#0 tx_data_tb <= 8'b11101111;
	#0 tx_enable_tb <= 1;
	#0 uld_rx_data_tb <= 0;
	#0 rx_enable_tb <= 1;
	#0 rx_in_tb <= 1;

	*/
	#0  reset_tb <= 0;
	//	resetclk_tb <= 0;
		rx_in_tb <= 0;

	#10 reset_tb <= 1;
	//	resetclk_tb <= 1;

	//#10 resetclk_tb <= 0;

	#10 reset_tb <= 0;

	#100000 rx_in_tb <= 1;

	#300000 rx_in_tb <= 0;

	#300000 rx_in_tb <= 1;
	
	#(tck*500000) $finish;
end
endmodule
