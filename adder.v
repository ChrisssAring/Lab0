`define AND and #50
`define OR or #50
`define XOR xor #50

// Adder circuit

module behavioralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    // Uses concatenation operator and built-in '+'
    assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
  wire AxorB;
	wire AandB;
	wire AxorBandCarryIn;

	`XOR (AxorB, a, b);
	`XOR (sum, AxorB, carryin);
	`AND (AandB, a, b);
	`AND (AxorBandCarryIn, AxorB, carryin);
	`OR (carryout, AxorBandCarryIn, AandB);
endmodule

module FullAdder4bit
(
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b      // Second operand in 2's complement format
);

	wire carryout0;
	wire carryout1;
	wire carryout2;

	structuralFullAdder a0(sum[0], carryout0, a[0], b[0], 1'b0);
	structuralFullAdder a1(sum[1], carryout1, a[1], b[1], carryout0);
	structuralFullAdder a2(sum[2], carryout2, a[2], b[2], carryout1);
	structuralFullAdder a3(sum[3], carryout, a[3], b[3], carryout2);

	`XOR (overflow, carryout2, carryout);
endmodule
