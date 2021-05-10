avr_include_dir = include
arduino_include_dir = include/arduino
avrdude_parms = -c arduino -p m328p -P /dev/ttyUSB0

compiler_flags = -DF_CPU=16000000 -mmcu=atmega328p -Os -ffunction-sections -fdata-sections -flto -I$(avr_include_dir) -I$(arduino_include_dir)
linker_flags = -DF_CPU=16000000 -mmcu=atmega328p -Wl,--gc-sections -flto

help:
	@echo 'check: check connected board'
	@echo 'build: compile C source to hex file'
	@echo 'flash: flash hex file to the controller'
	@echo 'clean: remove intermediate files'
check:
	avrdude $(avrdude_parms)
build:
	mkdir -p obj
	# Compile main source file
	avr-gcc -c $(compiler_flags) main.cpp -o main.o
	# Compile any additional files here
	# avr-gcc -c $(compiler_flags) additional.c -o additional.o
	# Link all object files
	avr-gcc $(linker_flags) *.o -o program.bin
	# Convert binary to flashable HEX
	avr-objcopy -j .text -j .data -O ihex program.bin program.hex
	# Show some info about the HEX file
	# Pay attention to size, it should not exceed 31.5KB
	avr-size program.hex
flash:
	avrdude $(avrdude_parms) -U flash:w:program.hex
clean:
	rm -rf *.o *.bin *.hex