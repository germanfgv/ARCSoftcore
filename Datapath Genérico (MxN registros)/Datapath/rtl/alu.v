module alu #(
parameter M=8
)(
input[M-1:0] rga,rgb,
input[1:0] selection,
output reg [M-1:0] res,
output reg ov,carry,neg,zero
);
reg rCarry;
reg [2:0] sState,rState;

parameter Or=3;
parameter And=2;
parameter Add=1;
parameter Rga=0;

//Setting State
always@(*)
begin
	rState<=sState;
end

always@(*)
begin
	case(selection)
	0:sState=Rga;
	1:sState=Add;
	2:sState=And;
	3:sState=Or;
	endcase
end

//Making Operation
always@(*)
begin
case(rState)
	3:begin res=rga|rgb;rCarry=0;end
	2:begin res=rga & rgb;rCarry=0;end
	1:begin {rCarry,res}=rga+rgb;end
	0:begin res=rga;rCarry=0;end
endcase
end


// Flags
always@(*)
begin
carry = rCarry;
begin
	if((rga[M-1]==1 && rgb[M-1]==1 && res[M-1]==0 ) || (rga[M-1]==0 && rgb[M-1]==0 && res[M-1]==1 ) )
		ov<=1;
	else	
			ov<=0;
end

if(res==0)
	zero=1;
else
	zero=0;	
if(res<0)
	neg=1;
else
	neg=0;	
	
end
endmodule


