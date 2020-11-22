INCLUDE = -I.

all: build_rwbmp test_rwbmp
	@echo -n
build_rwbmp:
	gcc -O3 -o rwbmp rwbmp.c
test_rwbmp:
	./rwbmp
clean:
	rm -rf rwbmp output.bmp
.PHONY: all build_rwbmp test_rwbmp clean
