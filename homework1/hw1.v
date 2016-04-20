module decoder(op1, op0, OP_AND, OP_OR, OP_XOR, OP_NOT);
  input op1, op0;
  output OP_AND, OP_OR, OP_XOR, OP_NOT;

  assign OP_AND = ~op1 & ~op0;
  assign OP_OR = op1 & ~op0;
  assign OP_XOR = ~op1 & op0;
  assign OP_NOT = op1 & op0;

endmodule

module compute(data1, data0, out_and, out_or, out_xor, out_not);

  // data
  input data1, data0;
  output out_and, out_or, out_xor, out_not;

  assign out_and = data1 & data0;
  assign out_or = data1 | data0;
  assign out_xor = data1 ^ data0;
  assign out_not = ~data0;

endmodule

module zzz(op1, op0, data1, data0, out);

  input op1, op0, data1, data0;
  output out;

  // results from compute
  wire res_and, res_or, res_xor, res_not;
  wire op_and, op_or, op_xor, op_not;

  compute asdf(data1, data0, res_and, res_or, res_xor, res_not);
  decoder qwer(op1, op0, op_and, op_or, op_xor, op_not);

  assign out = (res_and & op_and) | (res_or & op_or) | (res_xor & op_xor) | (res_not & op_not);
endmodule

module test();

  reg op1, op0, data1, data0;
  wire out;
  integer i;

  zzz zzzout(op1, op0, data1, data0, out);

	initial begin
			for(i=0;i<16;i+=1) begin
  			{op1, op0, data1, data0} = i;
      	#1
  			$display("Op code: %b%b data: %b%b output: %b", op1, op0, data1, data0, out);

        case (i)
          0: $display("AND");
          4: $display("OR");
          8: $display("XOR");
          12: $display("NOT");
        end
			end
	end
endmodule
