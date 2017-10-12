OS := $(shell uname)

ifeq ($(OS), Darwin)
CFLAG := 
else
CFLAG := -lrt
endif

PO := -O0 -O1 -O2 -O3
P1 := $(addprefix p1, $(PO))
P2 := $(addprefix p2, $(PO))

all: p1-O3 $(P2)

$(P1): main.c common.h
	gcc $(CFLAG) $(subst p1,,$@) $< -o $@

$(P2): main2.c common.h
	gcc $(CFLAG) $(subst p2,,$@) $< -o $@

.PHONY: test test2 clean

test-all: test test2

test:
	./p1-O3 >> p1-O3.output

test2:
	./p2-O0 2048 >> p2-O0.output
	./p2-O1 2048 >> p2-O1.output
	./p2-O2 2048 >> p2-O2.output
	./p2-O3 2048 >> p2-O3.output


clean:
	rm -rf p1 p2 $(P1) $(P2) *.o* *.e*
