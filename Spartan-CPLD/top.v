`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    18:16:02 08/16/05
// Design Name:    
// Module Name:    top
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 

// Regision 0.03 - Scott S.: added DONE to override the tristate of A21-A24
// Revision 0.02 - Scott S.: added A21-A24 control
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module top(m0, m1, m2, DONE, XCF_CE_B, A);
    input m0;
    input m1;
    input m2;
	 input DONE;
    output XCF_CE_B; // XCF_CE_B is the Chip Enable for the Platform Flash
    output [24:20]A;

reg [24:20] A;

assign XCF_CE_B = (m0 | m1 | m2);  // "Or Gate" to dissable Platform Flash when not in MS mode

always @(m0 or m1 or m2 or DONE) // Assign A20-A24 0's during BPI up, 1's down, tristate when DONE
	begin
		case ({m0, m1, m2, DONE})
			4'b0100 : A = 5'b00000; // A20-A24 is all 0's when BPI Up Mode and DONE=0
			4'b1100 : A = 5'b11111; // A20-A24 is all 1's when BPI Up Mode and DONE=0
			default: A = 5'bZZZZZ; // Otherwise tristated
		endcase
	end

endmodule

