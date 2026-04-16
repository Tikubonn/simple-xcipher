
export GCC=gcc
export CFLAGS=-Wall
# export CFLAGS=-Wall -g -Og #for debug build.
# export CFLAGS=-Wall -O3 -finline-functions #for release build.

all: dist/include/simple-xcipher/simple-xcipher.h dist/lib/libsimplexcipher.a dist/lib/libsimplexcipher.so bin/simple-xcipher

.PHONY: clean
clean:
	rm -f src/simple-xcipher.o
	rm -f src/main.o
	make -C test clean

.PHONY: test
test: all 
	make -C test SIMPLE_XCYPHER_INCLUDE=$(CURDIR)/dist/include SIMPLE_XCYPHER_LIB=$(CURDIR)/dist/lib

.PHONY: test-bin 
test-bin: all
	make -C test test-bin SIMPLE_XCYPHER_BIN=$(CURDIR)/bin

src/simple-xcipher.o: src/simple-xcipher.c src/simple-xcipher.h
	$(GCC) $(CFLAGS) -c -o src/simple-xcipher.o src/simple-xcipher.c

dist/include/simple-xcipher:
	mkdir -p dist/include/simple-xcipher

dist/include/simple-xcipher/simple-xcipher.h: src/simple-xcipher.h | dist/include/simple-xcipher
	cp src/simple-xcipher.h dist/include/simple-xcipher/simple-xcipher.h

dist/lib:
	mkdir -p dist/lib

dist/lib/libsimplexcipher.a: src/simple-xcipher.o | dist/lib
	ar r dist/lib/libsimplexcipher.a src/simple-xcipher.o

dist/lib/libsimplexcipher.so: src/simple-xcipher.o | dist/lib
	$(GCC) $(CFLAGS) -shared -o dist/lib/libsimplexcipher.so src/simple-xcipher.o

bin:
	mkdir -p bin

src/main.o: src/main.c src/buffer.h dist/include
	$(GCC) $(CFLAGS) -Idist/include -c -o src/main.o src/main.c

bin/simple-xcipher: src/main.o dist/lib/libsimplexcipher.a | bin
	$(GCC) $(CFLAGS) -Ldist/lib -o bin/simple-xcipher src/main.o -lsimplexcipher
