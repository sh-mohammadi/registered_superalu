module registered(inp);
input [47 : 0] inp;

wire [15 : 0] out1, out2, out3, out4, alu_out;
wire [7 : 0] mux_o1, mux_o2, mux_o3, mux_o4;
//[47|op1|45]-[44|op2|42][41|op3|39]-[r1s|38][37|num1|30]-[r2s|29][28|num2|21]-[r3s|20][19|num3|12]-[r4s|11][10|num4|3]-[2|reg|0]

mux8 a0 (.select(inp[38]), .a(inp[37 : 30]), .b(out1[7 : 0]), .out(mux_o1));
mux8 a1 (.select(inp[29]), .a(inp[28 : 21]), .b(out2[7 : 0]), .out(mux_o2));
mux8 a2 (.select(inp[20]), .a(inp[19 : 12]), .b(out3[7 : 0]), .out(mux_o3));
mux8 a3 (.select(inp[11]), .a(inp[10 : 3 ]), .b(out4[7 : 0]), .out(mux_o4));

register_module r0 (.oa1(inp[37 : 30]), .oa2(inp[28 : 21]), .oa3(inp[19 : 12]), .oa4(inp[10 : 3]),
 .in_address(inp[2 : 0]), .data(alu_out), .out1(out1), .out2(out2), .out3(out3), .out4(out4));

super_alu s0(.in({inp[47:39], mux_o1, mux_o2, mux_o3, mux_o4}) ,.out(alu_out));
endmodule

module register_module(oa1, oa2, oa3, oa4, in_address, data, out1, out2, out3, out4);
input [7 : 0] oa1, oa2, oa3, oa4;
input [2 : 0] in_address;
input [15 : 0] data;
output reg [15 : 0] out1, out2, out3, out4;

reg [15 : 0] register [7 : 0];

//oa: out address
always@(oa1)
	out1 = register[oa1];
always@(oa2)
	out2 = register[oa2];
always@(oa3)
	out3 = register[oa3];
always@(oa4)
	out4 = register[oa4];
always@(in_address or data)
	register[in_address] = data;

endmodule

module mux8(select, a, b, out);
input select;
input [7 : 0] a, b;
output reg [7 : 0]out;

always@(*)
begin
	case(select)
		1'b0 : out = a;
		1'b1 : out = b;
	endcase
end
endmodule

module registered_tb;
	reg [47:0] inp;

	processor uut (
		.inp(inp)
	);

	initial begin
		inp = 48'b000010100000001100000000110000000010000000100000;//(12+6)*(2^4) = 288 => @0;
		#100;
		inp = 48'b000011010000001010000001000000000011000000011010;//(10+8)-(3*3) = 2 => @2
		#100;
	end
      
endmodule
