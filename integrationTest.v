module bin2bcd(
   input [5:0] bin,
   output reg [7:0] bcd
);

integer i;

always @(bin) begin
    bcd=0;
    for (i=0; i<6; i=i+1) begin
        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;
        if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
        bcd = {bcd[6:0], bin[5-i]};
    end
end

endmodule

module disp(
    input [7:0] bcd,
    output reg [6:0] segmentDigit1,
    output reg [6:0] segmentDigit2,
    output reg [7:0] decimalOutput
);
    integer tens, ones;

    always @(bcd) begin
        tens = bcd[7:4];
        ones = bcd[3:0];
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
    wire [5:0] binaryInput;
    wire [7:0] bcd;
    wire [6:0] segmentDigit1;
    wire [6:0] segmentDigit2;
    wire [7:0] decimalOutput;

    // Declare reg variable for binaryInput
    reg [5:0] binaryInput_reg;

    // Instantiate the module to be tested
    bin2bcd bin2bcd_inst (
        .bin(binaryInput_reg),
        .bcd(bcd)
    );
    disp disp_inst (
        .bcd(bcd),
        .segmentDigit1(segmentDigit1),
        .segmentDigit2(segmentDigit2),
        .decimalOutput(decimalOutput)
    );

    // Declare file handle
    integer file;

    // Test inputs
    initial begin
        binaryInput_reg = 6'b000011;
        #10;
        $display("segmentDigit1 = %h, segmentDigit2 = %h, decimalOutput = %d", segmentDigit1, segmentDigit2, decimalOutput);

        // Open file for writing
        file = $fopen("output.txt", "w");

        // Write outputs to file
        $fwrite(file, "%b%b", segmentDigit1, segmentDigit2);

        // Close file
        $fclose(file);

        // End simulation
        $finish;
    end
endmodule

