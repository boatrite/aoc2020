DAYS = 1 2

all: $(addprefix build/day, $(DAYS))
run_all: $(addprefix run_day, $(DAYS))

clean:
	rm -r build

.PHONY: all clean

#
# Compiler flags
#
CC = g++
CFLAGS = -std=c++17 \
				 -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion

#
# Build Template
#
define build_template
watch_day$(1): build/day$(1)
	find src -type f | entr sh -c 'make run_day$(1)'

run_day$(1): build/day$(1)
	@./build/day$(1)

day$(1): build/day$(1)

.PHONY: watch_day$(1) run_day$(1) day$(1)

build/day$(1): src/day$(1).cpp | build
	$$(CC) -o $$@ $$<

endef

build:
	mkdir -p build

#
# Builds
#
$(foreach num,$(DAYS),$(eval $(call build_template,$(num))))

info:
	$(foreach num,$(DAYS),$(info $(call build_template,$(num))))

.PHONY: info
