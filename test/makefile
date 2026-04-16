
export GCC=gcc
export CFLAGS+=-I$(SIMPLE_XCYPHER_INCLUDE) -L$(SIMPLE_XCYPHER_LIB)

.PHONY: all
all: bin/test
	gdb bin/test

.PHONY: test-bin
test-bin: scripts/test-simple-xcipher.bash scripts/test.bash
	env PATH="$(PATH):$(SIMPLE_XCYPHER_BIN)" ./scripts/test-simple-xcipher.bash

.PHONY: clean
clean: 
	rm -f src/test-simple-xcipher-calc-encrypted-data-size.o
	rm -f src/test-simple-xcipher-encrypt-decrypt.o
	rm -f src/main.o

src/test-simple-xcipher-calc-encrypted-data-size.o: src/test-simple-xcipher-calc-encrypted-data-size.c src/test-simple-xcipher-calc-encrypted-data-size.h $(SIMPLE_XCYPHER_INCLUDE)
	$(GCC) $(CFLAGS) -c -o src/test-simple-xcipher-calc-encrypted-data-size.o src/test-simple-xcipher-calc-encrypted-data-size.c 

src/test-simple-xcipher-encrypt-decrypt.o: src/test-simple-xcipher-encrypt-decrypt.c src/test-simple-xcipher-encrypt-decrypt.h src/test.h $(SIMPLE_XCYPHER_INCLUDE)
	$(GCC) $(CFLAGS) -c -o src/test-simple-xcipher-encrypt-decrypt.o src/test-simple-xcipher-encrypt-decrypt.c

src/main.o: src/main.c src/test-simple-xcipher-calc-encrypted-data-size.h src/test-simple-xcipher-encrypt-decrypt.h $(SIMPLE_XCYPHER_INCLUDE)
	$(GCC) $(CFLAGS) -c -o src/main.o src/main.c

bin: 
	mkdir -p bin

bin/test: src/test-simple-xcipher-calc-encrypted-data-size.o src/test-simple-xcipher-encrypt-decrypt.o src/main.o $(SIMPLE_XCYPHER_LIB) | bin
	$(GCC) $(CFLAGS) -o bin/test src/test-simple-xcipher-calc-encrypted-data-size.o src/test-simple-xcipher-encrypt-decrypt.o src/main.o -lsimplexcipher
