
#include <stdio.h>
#include <stdlib.h>

unsigned char * correct(unsigned char * buf, unsigned char byte, unsigned count) {
    int cur = 0;

    while(*buf) {
        if(*buf == byte) cur++; else cur = 0;
        if(cur == count) return buf - count + 1;
        buf++;
    }
}

#define entry correct

int main(void) {
    unsigned char * buf = malloc(2048);
    srand(time(NULL));
    for(int i = 0; i < 2048; i++)
        buf[i] = rand() % 254 + 1;
    unsigned addr = rand() % 2036;
    unsigned count = rand() % 10 + 1;
    unsigned char byte = rand() % 253 + 1;
    for(int i = 0; i < count; i++)
        buf[addr + i] = byte;
    buf[2047] = 0;
    
    if(correct(buf, byte, count) != entry(buf, byte, count))
        puts("failed");
    else
        puts("passed");
}
