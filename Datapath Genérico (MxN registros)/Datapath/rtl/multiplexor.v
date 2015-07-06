module multiplexor #(
parameter N=4, //Número de registros del datapath
parameter M=8, //Número de bits por registro
parameter P=2  //Número de bits de la señal de selección
)
(
input [P-1:0]selection,
input[M*N-1:0] datain,
output reg[M-1:0] dataout
);

reg [M*N-1:0] temp;
always@(*)
begin
temp= datain>>(M*selection);
dataout= temp[M-1:0];
end
endmodule



