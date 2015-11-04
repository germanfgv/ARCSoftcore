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
reg        	clk_tb,w_wr,w_rd;
reg        	rst_tb;
reg	   	w_ack;
wire       	led_tb;
reg	[7:0]   w_data, data_IO_tb;


reg		hab_deco_tb;
reg	[4:0]	in_deco_tb;



//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------
system #(
	.clk_freq	(	clk_freq	)
) dut  (
	.clk(	clk_tb	),
	.rst(rst_tb),
	.denv(w_data),
	.drec(),
	.wr(w_wr),
	.rd(w_rd),
	.habilitarDecodificador(hab_deco_tb),
	.entradaDecodificador(in_deco_tb),
	.data_IO(data_IO_tb),
	.salidaMemoriaR()
	
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
	#0   w_wr   <= 0; 
	#0   w_rd   <= 0;
	#0   hab_deco_tb <=0;
	#0   in_deco_tb <=0;
	#0   data_IO_tb <=0;
	#10  hab_deco_tb <=0;
	#15  in_deco_tb <= 0;
	#20  data_IO_tb <=8'b10101010;
	#20  hab_deco_tb <=1;
	#20  hab_deco_tb <=0;
	#20  data_IO_tb <=8'b11110000;
	#20  in_deco_tb <=1;	
	#20  hab_deco_tb <=1;
	#20  hab_deco_tb <=0;




	
	#(tck*500000) $finish;
end
endmodule
