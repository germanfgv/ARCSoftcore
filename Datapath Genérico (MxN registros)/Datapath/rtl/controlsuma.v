module controlsuma(
input clk, fov,fcarry,fneg,fzero,
output reg [7:0]instreg,instmulta,instalu,instmultb,
output reg escr1,escr2,escr3,escr0
);

reg rEstado, sEstado;

parameter  AssignFunc = 0;
parameter  SavingData   = 1;


initial
begin
	sEstado=AssignFunc;
end

always@(posedge clk)
begin

if(sEstado==AssignFunc)
begin
escr0=0;
escr1=0;
escr2=0;
escr3=0;
instmulta=1;
instmultb=2;
instalu=1;
instreg=0;
//estado futuro-------------------------------------------
rEstado=SavingData;
end

else if(sEstado==SavingData)
begin
escr0=1;
escr1=0;
escr2=0;
escr3=0;
instmulta=1;
instmultb=2;
instalu=0;
instreg=0;
//estado futuro-------------------------------------------
rEstado=AssignFunc;
end

sEstado=rEstado;

end
endmodule
