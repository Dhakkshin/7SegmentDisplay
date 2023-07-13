import numpy as np
import matplotlib.pyplot as plt

# Create a bit stream
with open("output.txt", "r") as f:
    bits = f.read()
    bit_stream_1 = [int(i) for i in bits[:7]]
    bit_stream_2 = [int(i) for i in bits[7:14]]

# Create the first seven segment display
display1 = np.zeros((7, 5), dtype=int)

# Create the second seven segment display
display2 = np.zeros((7, 5), dtype=int)

for i in range(len(bit_stream_1)):
    if bit_stream_1[i] == 1:
        if i == 0:
            display1[1][1] = display1[1][2] = display1[1][3] = 1
        
        if i == 1:
            display1[1][3] = display1[2][3] = display1[3][3] = 1

        if i == 2:
            display1[3][3] = display1[4][3] = display1[5][3] = 1

        if i == 3:
            display1[5][1] = display1[5][2] = display1[5][3] = 1
        
        if i == 4:
            display1[3][1] = display1[4][1] = display1[5][1] = 1
        
        if i == 5:
            display1[1][1] = display1[2][1] = display1[3][1] = 1

        if i == 6:
            display1[3][1] = display1[3][2] = display1[3][3] = 1

for i in range(len(bit_stream_2)):
    if bit_stream_2[i] == 1:
        if i == 0:
            display2[1][1] = display2[1][2] = display2[1][3] = 1
        
        if i == 1:
            display2[1][3] = display2[2][3] = display2[3][3] = 1

        if i == 2:
            display2[3][3] = display2[4][3] = display2[5][3] = 1

        if i == 3:
            display2[5][1] = display2[5][2] = display2[5][3] = 1
        
        if i == 4:
            display2[3][1] = display2[4][1] = display2[5][1] = 1
        
        if i == 5:
            display2[1][1] = display2[2][1] = display2[3][1] = 1

        if i == 6:
            display2[3][1] = display2[3][2] = display2[3][3] = 1

# Display the bit stream on the first seven segment display
plt.subplot(1, 2, 1)
plt.imshow(display1, cmap="gray")
plt.axis('off')
plt.title('Display 1')

# Display the bit stream on the second seven segment display
plt.subplot(1, 2, 2)
plt.imshow(display2, cmap="gray")
plt.axis('off')
plt.title('Display 2')

plt.tight_layout()
plt.show()
