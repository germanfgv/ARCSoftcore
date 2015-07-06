
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
	input		clk, rst
);

wire [1:0] winstreg,winstmulta,winstalu,winstmultb;
wire wfov,wfcarry,wfneg,wfzero, werst;
wire [3:0]wescr;

controlfibonacci cf(
.fov(wfov),
.rst_in(rst),
.fcarry(wfcarry),
.fneg(wfneg),
.fzero(wfzero),
.clk(clk),
.selection_sr(winstreg),
.selection_multa(winstmulta),
.selection_alu(winstalu),
.selection_multb(winstmultb),
.writer(wescr),
.rst_out(werst)
);

datapath dapa (
.fov(wfov),
.fcarry(wfcarry),
.fneg(wfneg),
.fzero(wfzero),
.clk(clk),
.rst(rst),
.selection_sr(winstreg),
.selection_multa(winstmulta),
.selection_alu(winstalu),
.selection_multb(winstmultb),
.writer(wescr)
);

endmodule
