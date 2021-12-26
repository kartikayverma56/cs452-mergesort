CC = gcc
CFLAGS = -Wall -Wextra -Wpointer-arith -Wstrict-prototypes -std=gnu89 -fPIC -MMD -MP
LDFLAGS = -shared

all: libmazda.so test-mazda

#This builds a shared library.
libmazda.so: mazda.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

#This builds an executable it depends on the library
test-mazda: test-mazda.o libmazda.so
	$(CC) $(CFLAGS) $< -L. -Wl,-rpath=. -lmazda -o $@

.PHONY: clean
clean:
	$(RM) *.o *.d *.gcno *.gcda *.gcov libmazda.so test-mazda

-include *.d
