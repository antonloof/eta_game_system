# Eta game system
Playing games on a wall of TLS3001. Driven by a raspberry pi pico

## important docs
https://github.com/FastLED/FastLED/issues/1

Summary:
Manchester encoded data:
1 => 10
0 => 01
Timing is critical, keep constant period!
When sleeping put data low!

Sync frame: "1"*15+"0001"+"0"*11
(111111111111111000100000000000)

Reset frame: "1"*15 + "0100"
(1111111111111110100)

Data frame header: "1"*15 + "0010" 
(1111111111111110010)

Data content: "0"+"x"*12 + "0"+"x"*12 + "0"+"x"*12
where x is the rgb data to send total 39 bits per led
repeat this for all leds in series

The source:
Data communication protocol: 

Gave SDI input signal pin must follow the following definitions:

a. valid input data must be Manchester encoded signal. 

(from high to low transition indicates "1", from low to high Jump indicates "0")

b. During chip power after a synchronization frame must be sent to the chip detection of communication baud rate. Sync frame

Format is: 15'b111111111111111 + 4' b0001 +11' b00000000000, sending synchronization

Frame must be delayed for some time and then send the data frame, so that each chip can be done in order to accurately detect

To the communication baud rate, delay time (us) greater than: Connection chip count ÷ communication baud rate (MHz) × 30

c. several frames in the transmission data, re-send a reset frame, wait 1ms later, send it again with the

Step frames for the chip to eliminate the accumulated error, reset frame format:

15'b111111111111111 +4' b0100

d. data frame format is: 15'b111111111111111 +4' b0010 (header) + first chip

39bit second chip 39bit data + data + ...... + n-th chip 39bit data

e. first chip is first received data chips, chip data format is: 1 'b0 (identification bits) + 12'

bxxxxxxxxxxxx (output port 1 data) + 1'b0 (flag) + 12'bxxxxxxxxxxxx (input

The port 2 data) + 1'b0 (flag) + 12'bxxxxxxxxxxxx (output port 3 data),

x is 1 or the 0

f. data is first sent MSB (most significant bit)

g. SDI input pin in the idle state, must remain low

h. the same frame data transmission process, must be sent contiguously, in the middle, without interruption, transmission frequency can not be Changed.