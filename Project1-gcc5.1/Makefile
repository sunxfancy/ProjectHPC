OS := $(shell uname)

ifeq ($(OS), Darwin)
CFLAG := 
else
CFLAG := -lrt
endif

PO := -O0 -O1 -O2 -O3
P1 := $(addprefix p1, $(PO))
P2 := $(addprefix p2, $(PO))
TP1 := $(addprefix test-, $(P1))
TP2 := $(addprefix test-, $(P2))

all: $(P1) $(P2)

$(P1): main.c common.h
	gcc $(CFLAG) $(subst p1,,$@) $< -o $@

$(P2): main2.c common.h
	gcc $(CFLAG) $(subst p2,,$@) $< -o $@


.PHONY: test-all test-p2 $(TP1) $(TP2) clean

test-all: $(TP1) $(TP2)

test-p2: $(TP2)

$(TP1):
	./$(subst test-,,$@)

$(TP2):
	./$(subst test-,,$@) 2048 -N

clean:
	rm -rf p1 p2 $(P1) $(P2) *.o* *.e*
