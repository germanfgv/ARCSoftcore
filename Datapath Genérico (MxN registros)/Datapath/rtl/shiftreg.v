module shiftreg#(
parameter M=8
)
(
input[M-1:0] res,
input [1:0] selection,
input clk,
output reg [M-1:0] salreg
);

always@(clk)
begin
if(selection==0 || selection==3)
salreg=res;
else if(selection==2)
salreg=res<<1;
else if(selection==1)
salreg=res>>1;
end
endmodule

