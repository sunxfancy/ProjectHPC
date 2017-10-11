OS := $(shell uname)

ifeq ($(OS), Darwin)
CFLAG := -O3
else
CFLAG := -O3 -lrt
endif

p1:
	gcc $(CFLAG) main.c -o p1

.PHONY: test clean

test:
	./p1

clean:
	rm -rf p1 p2 *.o* *.e*
