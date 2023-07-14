module disp(
    input [5:0] binaryInput,
    input clk,rst,up,down,
    output reg [6:0] segmentDigit1,
    output reg [6:0] segmentDigit2,
    output reg [7:0] decimalOutput
);
    integer tens, ones;
    wire [7:0] data;
    counter ct1(
        .clk(clk),
        .up(up),
        .down(down),
        .rst(rst),
        .count(binaryInput)
    );

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

module counter(clk,up,down,rst,count);
  //define input and output ports
  input clk,up,down,rst;
  output reg [5:0] count;
  //always block will be executed at each and every positive edge of the clock
  always@(posedge clk) 
  begin
    if(rst)
      count <= 6'd0;
    else if(up)        //count up
      count <= count + 1;
    else if(down)        //count up
      count <= count + 1;
    
  end

endmodule


module testbench;

    // Declare inputs and outputs
    reg [5:0] binaryInput;
    wire [6:0] segmentDigit1;
    wire [6:0] segmentDigit2;
    wire [7:0] decimalOutput;
    wire [5:0] data;
    reg clk,rst,up,down;

    // Instantiate the module to be tested

    counter ct1(
        .clk(clk),
        .up(up),
        .down(down),
        .rst(rst),
        .count(data)
    );

    disp disptb(
        .binaryInput(binaryInput),
        .segmentDigit1(segmentDigit1),
        .segmentDigit2(segmentDigit2),
        .decimalOutput(decimalOutput)
    );
    
    // Declare file handle
    integer file;

    initial begin
        rst = 1;
        clk = 1'b0;
        up = 1;
        binaryInput = 6'd0;
        #10;
        rst = 0;
    end

    initial begin
        clk = 1'b0;
        repeat(100) begin
            #5;
            clk = ~clk;
        end
    end

    always @(negedge clk) begin
        binaryInput = data;
    end

    // Test inputs
    initial begin
        #10;
        $monitor("time = %0d,clk = %0d, counter value = %0d, segmentDigit1 = %b, segmentDigit2 = %b, decimalOutput = %d",$time,clk,binaryInput, segmentDigit1, segmentDigit2, decimalOutput);
        
        // Open file for writing
        // file = $fopen("output.txt", "w");
        
        // // Write outputs to file
        // $fwrite(file, "segmentDigit1 = %b, segmentDigit2 = %b, decimalOutput = %d", segmentDigit1, segmentDigit2, decimalOutput);
        
        // // Close file
        // $fclose(file);
        
        // End simulation
        $finish;
    end
    
endmodule
