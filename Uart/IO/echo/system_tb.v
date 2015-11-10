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
reg        	clk_tb;
reg        	rst_tb;
reg 	wr_tb, rd_tb, rx_tb, sIO_tb, sMM_IO_tb, sM_ALU_tb;
reg	   	w_ack;
wire       	led_tb;
reg	[7:0]   w_data, data_IO_tb,dataBBM_tb;


reg		hab_deco_tb;
reg	[4:0]	in_deco_tb;

reg habilitarMux_tb,habilitarMuxMMIO_tb;
reg [15:0] datoInMux_tb;

wire w_tx;
wire [7:0] w_lectura;



//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------
system #(
	.clk_freq	(	clk_freq	)
) dut  (
	.clk(	clk_tb	),
	.rst(rst_tb),
	.wr(wr_tb),
	.rd(rd_tb),
	.rx(rx_tb),
	.selectorMuxIO(sIO_tb),
	.selectorMuxMMIO(sMM_IO_tb),
	.selectorMuxALUCC(sM_ALU_tb),
	.tx(w_tx),
	.lectura(w_lectura)
);


/* Clocking device */
// Remember this is only for simulation. It never will be syntetizable //
initial         
		clk_tb <= 0;


always #(tck/2) clk_tb <= ~clk_tb;

/* Simulation setup */
initial begin
	//set the file for loggin simulation data
	$dumpfile("system_tb.vcd"); 
	//$monitor("%b,%b,%b",clk_tb,rst_tb,led_tb);
	//export all signals in the simulation viewer
	$dumpvars(-1, dut);
	//$dumpvars(-1,clk_tb,rst_tb,led_tb, dut);
	
	//$dumpvars(-1,clk_tb,rst_tb);
	#0   rst_tb <= 0;
	#0   wr_tb   <= 0; 
	#0   rd_tb   <= 0;
	#0	 rx_tb <= 1;
	#0 	 sIO_tb <= 0;
	#0 	 sMM_IO_tb <= 0;
	#0 	 sM_ALU_tb <= 0;

	#20   rst_tb <= 1;
	#20   rst_tb <= 0;

	#20 	sIO_tb <= 1; 
	#20 	sMM_IO_tb <= 1;
	#20		sM_ALU_tb <= 1;

	#20 	sIO_tb <= 0;

	#50 	rx_tb <= 0;
	#200 	rx_tb <= 1;

	#50		rd_tb <= 1;
	#5000 	rd_tb <= 0;

	#200 	sIO_tb <= 1; 


	
	#(tck*500000) $finish;
end
endmodule
