module disp(
    input [5:0] binaryInput,
    output reg [6:0] segmentDigit1,
    output reg [6:0] segmentDigit2,
    output reg [7:0] decimalOutput
);
    integer tens, ones;
    
    always @ (binaryInput) begin
        tens = binaryInput / 10;
        ones = binaryInput % 10;
        decimalOutput = tens * 10 + ones;
        case (tens)
            0: segmentDigit1 = 7'b1111110;
            1: segmentDigit1 = 7'b0110000;
            2: segmentDigit1 = 7'b1101101;
            3: segmentDigit1 = 7'b1111001;
            4: segmentDigit1 = 7'b0110011;
            5: segmentDigit1 = 7'b1011011;
            6: segmentDigit1 = 7'b1011111;
            7: segmentDigit1 = 7'b1110000;
            8: segmentDigit1 = 7'b1111111;
            9: segmentDigit1 = 7'b1111011;
            default: segmentDigit1 = 7'b0000000;
        endcase
        case (ones)
            0: segmentDigit2 = 7'b1111110;
            1: segmentDigit2 = 7'b0110000;
            2: segmentDigit2 = 7'b1101101;
            3: segmentDigit2 = 7'b1111001;
            4: segmentDigit2 = 7'b0110011;
            5: segmentDigit2 = 7'b1011011;
            6: segmentDigit2 = 7'b1011111;
            7: segmentDigit2 = 7'b1110000;
            8: segmentDigit2 = 7'b1111111;
            9: segmentDigit2 = 7'b1111011;
            default: segmentDigit2 = 7'b0000000;
        endcase
    end

endmodule
module testbench;

    // Declare inputs and outputs
    reg [5:0] binaryInput;
    wire [6:0] segmentDigit1;
    wire [6:0] segmentDigit2;
    wire [7:0] decimalOutput;

    // Instantiate the module to be tested
    disp disp(
        .binaryInput(binaryInput),
        .segmentDigit1(segmentDigit1),
        .segmentDigit2(segmentDigit2),
        .decimalOutput(decimalOutput)
    );
    
    // Declare file handle
    integer file;
    
    // Test inputs
    initial begin
        binaryInput = 6'b111000;
        #10;
        $display("segmentDigit1 = %b, segmentDigit2 = %b, decimalOutput = %d", segmentDigit1, segmentDigit2, decimalOutput);
        
        // Open file for writing
        file = $fopen("output.txt", "w");
        
        // Write outputs to file
        $fwrite(file, "segmentDigit1 = %b, segmentDigit2 = %b, decimalOutput = %d", segmentDigit1, segmentDigit2, decimalOutput);
        
        // Close file
        $fclose(file);
        
        // End simulation
        $finish;
    end
    
endmodule
