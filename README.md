# Arduino Uno programming using the AVR toolchain

This is a simple setup to program Arduino Uno using the AVR toolchain (AVR-GCC and AVRDUDE)

Why? You might not like Arduino's IDE. You might not need default Arduino libraries if you are trying to make your program smaller or faster. You might want to leard how to write lower-level C code and interact with registers, timers and interrupts directly.

This setup is intended to be as simple to use as possible, without going into too much detail or configuration.

## One-Time Setup

Install Make, AVR-GCC and AVRDUDE

For Debian-based Linux distributions `sudo apt install make avr-gcc avrdude`

For Windows machines, follow [these instructions from Adafruit](https://learn.adafruit.com/windows-tools-for-the-electrical-engineer/avr-toolchain)

Clone this repository `git clone https://github.com/antonyak/arduino-uno-avr-toolchain.git`

## Usage

Connect Arduino Uno to your machine and run `make check` to verify AVRDUDE recognizes it. If it does not, you might need to remove or adjust the device (`/dev/*`) in `avrdude_parms` variable in `makefile`.

Write your program in `main.cpp`, build it by running `make build` and flash it to Arduino Uno by running `make flash`.

## Make reference

- `make check`: check if Arduino Uno is connected
- `make build`: compile and link C/C++ source to a flashable hex file.
    - If you add any additional files to compile, such as libraries, add a corresponding line to `makefile` in a marked location.
    - Pay attention to size, it should not exceed 31.5KB, or it will overwrite Arduino Uno's bootloader
- `make flash`: flash hex file to the Arduino
- `make clean`: remove intermediate files

## Notes

This repo includes libraries from [AVR Libc](https://nongnu.org/avr-libc/) and [Arduino Core](https://github.com/arduino/ArduinoCore-avr/tree/master/cores/arduino)

The proper way to use AVR libraries is to install AVR Libc (Debian package `avr-libc`) and then add `usr/lib/avr/include` include directory to AVR-GCC. However, for the sake of simplicity, this is not done in this setup.