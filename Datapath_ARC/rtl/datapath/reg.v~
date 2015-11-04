module registro (
	input clk,writer,rst,
	input [7:0] datain,
	output [7:0] dataout
);

reg [7:0] datareg;

initial
begin
	datareg=0;
end




//OUTPUT LOGIC
	assign dataout=datareg;


//INPUT LOGIC
always@(negedge clk, posedge rst)
begin
	if(rst)
	 datareg=0;
	else if(writer)
	 datareg=datain;
	else
	 datareg=dataout;
end

endmodule
