module datapath(
input[1:0] selection_sr,selection_alu,
input[2:0]selection_multa,selection_multb,
input clk, rst,
input [N-1:0] writer,
output fov,fcarry,fneg,fzero
	);

//declaracion de parametros
parameter N=8; //Numero de registros del datapath
parameter M=8; //tamaño de los registros en bits

reg [N*M-1:0] inicial;
initial
	inicial=64'b0000000000000000000000000000000000000000000000000000000100000001;



//declaracion de cables
wire [M-1:0]wrga; //Wire bus a
wire [M-1:0]wrgb;//Wire bus b
wire [M-1:0]w_ans_alu; // Wire resultado ALU
wire [M-1:0] wdatain;// Wire dato entrada
wire [M*N-1:0] wdataout ; // Wire salida de los registros a los buses


genvar i;
generate for ( i = 0; i <= N-1; i = i+1 )
begin: reg_i
registro #(
.M(M)
) reg_i(
.inicial(inicial[M*(i+1)-1:M*i]),
.rst(rst),
.clk(clk),
.write(writer[i]),
.datain(wdatain),
.dataout(wdataout[M*(i+1)-1: M*i])
);
end
endgenerate

//Multiplexores

multiplexor #(.M(M),.N(N),.P(3))
rga(

.selection(selection_multa),
.datain(wdataout),
.dataout(wrga)
);

multiplexor #(.M(M),.N(N),.P(3))
rgb(
.selection(selection_multb),
.datain(wdataout),
.dataout(wrgb)
);

//Unidad Aritmetico-Lógica

alu #(.M(M)) al(
.rga(wrga),
.rgb(wrgb),
.selection(selection_alu),
.res(w_ans_alu),
.ov(fov),
.carry(fcarry),
.neg(fneg),
.zero(fzero)
);

shiftreg #(.M(M)) sr(
.selection(selection_sr),
.clk(clk),
.res(w_ans_alu),
.salreg(wdatain)
);

endmodule
