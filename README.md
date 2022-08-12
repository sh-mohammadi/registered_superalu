# registered_superalu
We added a register file that saves the output of ALU and quantifies input if necessary.
![processor](https://user-images.githubusercontent.com/95965466/184317235-a9c0bfe5-e27b-4045-b855-f595dc3f7db5.jpg)
We used multiplexers to handle the input of ALU.

The input itself instructs the value to be used from the registers or input bits.The format of the input is shown below:

[47| op1 |45]-[44| op2 |42]-[41| op3 |39]-[r1s |38]-[37| num1 |30]-[r2s |29]-[28| num2 |21]-[r3s |20]-[19| num3 |12]-[r4s |11]-[10| num4 |3]-[2| reg_address |0]
