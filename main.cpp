#define __AVR_ATmega328__

#include <avr/io.h>
#include <util/delay.h>

int main()
{
    // Set pin 13 as output
    DDRB |= (1 << 5);

    while(1)
    {
        // Blink the LED
        PORTB ^= (1 << 5);
        _delay_ms(500);
    }
}