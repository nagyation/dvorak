TARGET = dvorak
LIBS = -lm -lX11
CC = gcc
CFLAGS += -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)

install:
	cp $(TARGET) /usr/bin/
	cp 80-dvorak.rules /etc/udev/rules.d/
	cp dvorak@.service /etc/systemd/system/
	sudo udevadm control --reload
	sudo systemctl restart udev.service
	systemctl daemon-reload
