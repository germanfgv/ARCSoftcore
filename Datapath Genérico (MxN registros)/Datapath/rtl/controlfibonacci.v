module controlfibonacci(
input clk,fov,fcarry,fneg,fzero, rst_in,
output reg [7:0]selection_sr,selection_multa,selection_alu,selection_multb,
output reg rst_out,
output reg [3:0] writer
);

reg[2:0] sState, rState;

parameter [2:0] AssignFunc=3'b000;
parameter [2:0] PassingShift1=3'b001;
parameter [2:0] Save=3'b010; 
parameter [2:0] AssignFunc2=3'b011; 
parameter [2:0] PassingShift2=3'b100; 
parameter [2:0] Save2=3'b101;
parameter [2:0] Final=3'b110; 

initial 
begin
sState=AssignFunc;
end
// state register
	always @ (posedge clk, posedge rst_in)
	if (rst_in) rState <= AssignFunc;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	AssignFunc: sState = PassingShift1;
	PassingShift1: if(fcarry==1) sState = Final; else sState = Save;  
	Save: sState = AssignFunc2;
	AssignFunc2: sState = PassingShift2;
	PassingShift2: if(fcarry==1) sState = Final; else sState = Save2;
	Save2: sState = AssignFunc; 
	Final: sState = Final;
	default: sState = AssignFunc;
	endcase

// output logic

always@(posedge clk)
begin
if(rState==AssignFunc)
begin
writer=0;
selection_multa=2;
selection_multb=3;
selection_alu=1;
selection_sr=0;
rst_out=0;
end

else if(rState==PassingShift1)
begin
writer=0;
selection_multa=2;
selection_multb=3;
selection_alu=1;
selection_sr=0;
rst_out=0;
end

else if(rState==Save)
begin
writer=4'b0101;
selection_multa=2;
selection_multb=3;
selection_alu=0;
selection_sr=0;
rst_out=0;
end

else if(rState==AssignFunc2)
begin
writer=0;
selection_multa=2;
selection_multb=3;
selection_alu=1;
selection_sr=0;
rst_out=0;
end

else if(rState==PassingShift2)
begin
writer=0;
selection_multa=2;
selection_multb=3;
selection_alu=1;
selection_sr=0;
rst_out=0;
end
else if(rState==Save2)
begin
writer=4'b1001;
selection_multa=2;
selection_multb=3;
selection_alu=0;
selection_sr=0;
rst_out=0;
end
else if(rState==Final)
begin
writer=0;
selection_multa=0;
selection_multb=0;
selection_alu=0;
selection_sr=0;
rst_out=1;
end


end
endmodule
