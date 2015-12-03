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
#(parameter	clk_freq	= 50000000,
	parameter DIVS_BITS	= 2) (
	input		clk, rst,rx,rst_clk,
	output  		tx,
	output	[7:0]	mmd,
	output	[9:0]	address,
	output	[7:0]	data
);

/*Declaración de cables*/
wire 		w_clk;
wire [31:0] w_ir;// Instructión register
wire [40:0] w_mir;// Vicrocode instruction register
wire [3:0]  w_psr;// Vector que contiene los Condition Codes (flags)
wire [31:0] w_data_mm,// bus que lleva datos de la Main memory al datpath
	    	w_bus_a,//Bus A del datapath que sirve como address de la MM
	    	w_bus_b,//Bus B del datapath en el que se envian datos a la MM
	    	w_data_iomm;
wire [7:0] w_data_p;
wire [DIVS_BITS-1:0] w_count;

   counter #(.M(DIVS_BITS**2), .N(DIVS_BITS)) baud_gen_unit
      (.clk(clk), .reset(w_rst), .q(w_count), .max_tick(tick));


/*Decaración demódulos*/

	//Control section: Esté módulo controla la operación del datapath. Contiene toda la lógica que permite decidir 	los pasos a seguir para llevar a cabo la intrucciónes de la Main Memory. 
	control_section cs(
		.rst(w_rst),
		.clk(w_clk),
		.ir(w_ir),
		.w_psr(w_psr),
		.mir(w_mir)
		);


	//Datapath: Manipula los datos y realiza operaciones dependiendo de las instrucciones de la control section
	datapath dapa (
		.rst(w_rst),
		.clk(w_clk),
		.mir(w_mir),
		.data_MM(w_data_iomm),
		.w_psr(w_psr),
		.w_ir(w_ir),
		.busA(w_bus_a),
		.busB(w_bus_b),
		.data(data)
		);	


	multiplexor32b muxer_MM_IO(
		.selection(w_bus_a[12]),
		.datain({24'b0,w_data_p,w_data_mm}),
		.dataout(w_data_iomm)
		);


	//Main Memory: Contiene las instrucciónes a ejecutar
	main_memory mm(
		.clk(w_clk),
		.rst(w_rst),
		.rd(w_mir[19]&(~w_bus_a[12])),
		.wr(w_mir[18]&(~w_bus_a[12])),
		.address(w_bus_a),
		.data_in(w_bus_b),
		.data_out(w_data_mm)
		);


	perifericos p1(
		.clk(clk),
		.rst(w_rst),
		.rx(rx),
		.tx(tx),
		.rd(w_mir[19]),
		.wr(w_mir[18]),
		.s_io(w_bus_a[0]),
		.s_mmio(w_bus_a[12]),
		.data_in(w_bus_b[7:0]),
		.data_out(w_data_p)
		);

assign address = w_bus_a[11:2];
assign mmd=w_data_mm[7:0];
assign psr=w_psr;
assign w_clk = w_count[DIVS_BITS-1];
assign w_rst = ~rst;
/*debounce  debWR (
	.clk(w_clk), .reset(1'b0), .sw(~rst), .db_tick(w_rst), .db_level()
);*/

endmodule