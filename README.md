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
* Displaying said distance using clever code developed by Adam and Vojtěch.

## Hardware

For powering our device we're using an arduino board, simply for the reason that it has its own built-in convertor to 5V, and finally it's all wired up on a little breadboard. I/O from the sensor is then connected to the Nexys A7-50T's female inputs on its side.
