It's an interface based on Duty cycle.
The project is written in VHDL.
There is a reciever, transmitter, and a file that connects these two together.
A transmitter has an eight-bit parallel input and a serial output; It transmits the data to a serial input reciever with an eight-bit parallel output.
The transmitter gets a data between 0 and 160; zero's duty cycle is 10 percent and 160's is 90 percent. The other inputs' duty cycle increases by 1 if the input rises by 2. 