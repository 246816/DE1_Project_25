# DE1_Project_25
### Team Members

* Vojtěch Krehan
* Vítek Borovka
* Adam Lefner
* Lukáš Gergel

### Abstract

This project aims to measure distance using ultrasound. We're using ultrasonic sensor HS-SR04, connected to Nexys A7-50T board.

Our device will be able to measure, calculate, and display distane of the ultrasonic wave, sent from transceiver on the ultrasonic sensor, and detected by its complementary receiver. The time it took for the signal to bounce back from a wall/object/material etc. will be translated into distance by dividing the speed of sound waves by this measured time.

The distance is then converted into a binary signal, which is then displayed on the board's multiple 7-segment displays, and also on the board's LEDs.

# The main aspects of our project are:

* Being able to measure distance using ultrasound, based on the knowledge of the speed of sound waves.
* Displaying said distance using code developed by Adam and Vojtěch.


## Hardware

For powering our device we're using an arduino board, simply for the reason that it has its own built-in convertor to 5V, and finally it's all wired up on a little breadboard. I/O from the sensor is then connected to the Nexys A7-50T's inputs on its side.

![20250423_124614](https://github.com/user-attachments/assets/6d0d792f-2df3-441d-bbfa-ab50018a25d1)

## Software
# Top-level design

![elaborated_design](https://github.com/user-attachments/assets/1746b693-3376-4800-9321-ac2dd270c883)

First, we introduce the "echo_meas" component. This component takes the output signal from the ultrasonic sensor, and transforms it into a 20-bit long signal. The length of 21 bits was selected because of possible overlaps in measured distance, and to add redundancy.

![tb_echo_meas_1](https://github.com/user-attachments/assets/949c13e5-e39b-43df-8eab-6f177a51bcb1)

Echo_meas then outputs a signal called "pulse_len", which is the 21-bit long signal stated previously. This is basically the measured distance already, but in binary. It is then further processed in "distance_calculation" component, which takes the "pulse_len" signal, and converts it into real distance, but not until the previous component "echo_meas" has sent a signal called "done", which tells the next component that it can turn the whole sequence into real distance in centimeters.

![tb_distance_calculation](https://github.com/user-attachments/assets/699291fc-e778-433e-a05d-30a5762c338a)

Now the signal "distance", which is the real distance calculated with the knowledge of speed of sound waves, is put through the next two components, which are for displaying it's value so that we can see what we're actually measuring. First, it's sent to a component called "bin2cbd", that converts the input distance into 3 segments of hundreds, tens and ones. For example, 173 will be decoded as 1 -> hundreds, 7 -> tens, 3 -> ones. We're using 4-bit buses for these signals, which are able to display anything from 0 to 9 on their own, which adds up to 9-9-9 or 999, and also because it's sufficient enough for this project.

![tb_bin2bcd](https://github.com/user-attachments/assets/aec8412c-9888-45e3-bc98-0f4a1abc3e02)


