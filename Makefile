CC=gcc
CFLAGS=-Wall -Wextra -Werror -std=c23 -shared -fPIC
DEBFLAGS=-g

SODIR=./so
SRCDIR=./src
BINDIR=./bin
LIBDIR=$(shell gcc -print-file-name=libc.so | xargs dirname)

LIBNAME=threadpool

SRCS=$(SRCDIR)/$(LIBNAME).c
THREADPOOL_SO=lib$(LIBNAME).so
THREADPOOL_DEBUG_SO=$(SODIR)/lib$(LIBNAME)_debug.so

.PHONY: all debug install uninstall clean

all: $(THREADPOOL_SO)

debug: $(THREADPOOL_DEBUG_SO)

install: $(THREADPOOL_SO)
	install -m 755 $(SODIR)/$(THREADPOOL_SO) $(LIBDIR)
	install -m 644 $(SRCDIR)/*.h /usr/include

uninstall:
	rm -f $(LIBDIR)/$(THREADPOOL_SO)
	rm -f /usr/include/threadpool.h

$(THREADPOOL_SO): $(SRCS)
	@mkdir -p $(SODIR)
	$(CC) $(CFLAGS) $< -o $(SODIR)/$@

$(THREADPOOL_DEBUG_SO): $(SRCS)
	@mkdir -p $(SODIR)
	$(CC) $(CFLAGS) $(DEBFLAGS) $< -o $(SODIR)/$@

clean:
	rm -rf $(SODIR)/* $(BINDIR)/*
