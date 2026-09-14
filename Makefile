hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/.pico-sdk/toolchain/13_2_Rel1
CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

all: firmware.elf

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

main.i: main.c
	$(CPP) $< > $@


main.s: main.i
	$(CC) -S $< -o $@

main.o: main.s
	$(AS) $< -o $@

%.o: %.s
	$(AS) $< -o $@



.PHONY: clean, all

clean:
	rm -f main.o main.i main.s #rm -f main.i hello.txt 