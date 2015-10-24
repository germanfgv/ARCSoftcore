############################################################################
######SharkBoard V1.0 - Project Template     ###############################
############################################################################
#################################################################FES - JRB##
#
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
#/

FPGA_SIZE=100
VINCDIR=					\
	-I../rtl 				
SYN_SRC=

SIM_SRC=					\
	system_tb.v				
SRC=						\
	../system.v	 \
	../rtl/uart_tx.v  \
	../rtl/uart_rx.v   \
	../rtl/IO_mem.v     \
	../rtl/uart.v 	     \
	../rtl/counter.v      \
	../rtl/flag_buf.v      \
	../rtl/fifo.v 
	


#############################################################################
# Synthesis constants
SYNCLEAN=system.bgn system.drc system.mrp system.ngd system.pcf 
SYNCLEAN+=system.bld system.lso system.ncd system.ngm system.srp
SYNCLEAN+=system.bit system.svf system_signalbrowser.* system-routed_pad.tx
SYNCLEAN+=system.map system_summary.xml timing.twr
SYNCLEAN+=system-routed* system_usage* system.ngc param.opt netlist.lst
SYNCLEAN+=xst system.prj *ngr *xrpt  _xmsgs  xlnx_auto_0_xdb *html *log *xwbt

USAGE_DEPTH=0
SMARTGUIDE= 

#############################################################################
# Simulation constants
SIMCLEAN=system_tb.vvp system_tb.vcd verilog.log system_tb.vvp.list simulation

CVER=cver
GTKWAVE=gtkwave
IVERILOG=iverilog
VVP=vvp
	
#############################################################################
# 
sim: system_tb.vcd
syn: system.bit
view: system_tb.view
install: system.svf
#############################################################################
# Ikarus verilog simulation

system_tb.vvp:
	rm -rf  simulation && mkdir simulation
	cp system_tb.v system_conf.v system_tb.vcd.save.sav simulation && cd simulation && rm -f $@.list
	for i in $(SRC); do echo $$i >> simulation/$@.list; done
	for i in $(SIM_SRC); do echo $$i >> simulation/$@.list; done
	cd simulation && $(IVERILOG) -o $@ $(VINCDIR) -c $@.list -s $(@:.vvp=)

%.vcd: %.vvp
	cd simulation && $(VVP) $<

#############################################################################
# ISE Synthesis


system.prj:
	rm -rf build && mkdir build
	@rm -f $@
	for i in $(SRC); do echo verilog work $$i >> build/$@; done
	for i in $(SRC_HDL); do echo VHDL work $$i >> build/$@; done

system.ngc: system.prj
	cd build && xst -ifn ../system.xst

system.ngd: system.ngc system.ucf
	cd build && ngdbuild -uc ../system.ucf system.ngc

system.ncd: system.ngd
	cd build && map $(SMARTGUIDE) system.ngd

system-routed.ncd: system.ncd
	cd build && par $(SMARTGUIDE) -ol high -w system.ncd system-routed.ncd

system.bit: system-routed.ncd
	cd build &&  bitgen -w system-routed.ncd system.bit
	@mv -f build/system.bit $@

system.mcs: system.bit
	cd build && promgen -u 0 system

system-routed.xdl: system-routed.ncd
	cd build && xdl -ncd2xdl system-routed.ncd system-routed.xdl

system-routed.twr: system-routed.ncd
	cd build &&  trce -v 10 system-routed.ncd system.pcf

timing: system-routed.twr

usage: system-routed.xdl
	xdlanalyze.pl system-routed.xdl $(USAGE_DEPTH)

####################################################################
# SVF file
system.svf:
	impact -batch impact_batch_cmds
	sudo jtag urjtag_cmds
####################################################################
# final targets

%.view: %.vcd
	cd simulation && $(GTKWAVE) $< $<.save.sav

clean:
	rm -Rf build $(SYNCLEAN) $(SIMCLEAN) 

.PHONY: clean view


