PG_CONFIG ?= pg_config

EXTENSION = myext
EXTVERSION = 0.1.0

MODULE_big = $(EXTENSION)
DATA = $(wildcard sql/*--*.sql)
SRCS = src/myext.c
OBJS = src/myext.o
HEADERS = src/$(EXTENSION).h

TESTS = $(wildcard test/sql/*.sql)
REGRESS = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test --load-extension=$(EXTENSION)

.PHONY: dist

dist:
	mkdir -p dist
	git archive --format zip --prefix=$(EXTENSION)-$(EXTVERSION)/ --output dist/$(EXTENSION)-$(EXTVERSION).zip main

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
