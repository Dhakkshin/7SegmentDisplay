# 7SegmentDisplay
Digital Design project 

This is a system that uses verilog and Python to emulate the working of a seven-segment display.
---
## Instructions to use:
1. Make sure you have iverilog (Icarus verilog) and python installed before proceeding further.
2. run this script to get input from the user
  ```
python get_input.py
  ```
3. compile the test bench generated by the python script
  ```
iverilog -o sev-seg_tb.vpp sev-seg.v
  ```
4. execute the output file
  ```
vvp sev-seg_tb.vpp
```
5. run the script which draws the seven segment display output
  ```
python segmentDisplay.py
```
