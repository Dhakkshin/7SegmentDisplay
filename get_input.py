with open("1st.txt", "r") as f:
    lines = f.read()

lines += input("Enter 6 bit binary: ")

print(lines)

with open("2nd.txt", "r") as f:
    lines += f.read()

with open("integrationTest.v", "w") as f:
    f.write(lines)
