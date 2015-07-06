module control_section(
input clk,rst,ack,
input [31:0] ir,
input [3:0] w_psr, // vecor de flags de la ALU
output [40:0]mir
);

/* 
Declaración de cables
*/

wire [40:0] w_mir,w_mir_in;

wire [10:0] w_ir_addr;

wire [10:0] 
	    w_next_addr,//direccion inmediatamente siguiente a la direccion actual
	    w_cs_addr;// actual control store address

wire w_ir13; // bit 13 del instruction register
wire [2:0] w_cond; // Condiciones lógicas especificadas en la MIR
wire [1:0] w_sel_csa; // bits de selección del mulltiplexor de la csa


/*Logica combinacional*/
assign w_ir13=ir[13];
assign w_cond=w_mir[13:11];
assign w_ir_addr={1'b1,ir[31:30],ir[24:19],2'b00};
assign mir=w_mir;

/*Módulos*/

csai csai(
.actual_addr(w_cs_addr),
.ack(clk),
.rst(rst),
.next_addr(w_next_addr)
);


control_branch_logic cbl(
.ir13(w_ir13),
.psr(w_psr),
.cond(w_cond),
.out(w_sel_csa)
);

mux_csa csa_m(
.select(w_sel_csa),
.in_a(w_next_addr),
.in_b(w_mir[10:0]),
.in_c(w_ir_addr),
.in_d(0),
.out(w_cs_addr)
);

control_store cs(
.rst(rst),
.mir(w_mir_in),
.address(w_cs_addr)
);

m_mir mmir(
.in_mir(w_mir_in),
.clk(clk),
.rst(rst),
.out_mir(w_mir)
);


endmodule
