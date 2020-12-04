DAYS = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25

all: $(addprefix build/day, $(DAYS))
run_all: $(addprefix run_day, $(DAYS))

clean:
	rm -r build

.PHONY: all clean

#
# Compiler flags
#
CC = g++-10
CXXFLAGS = -std=c++20 \
				 -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion
DBG_CFLAGS = -g -O0 -DNDEBUG=0 # Debug

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
	$$(CC) $$(CXXFLAGS) $$(DBG_CFLAGS) -o $$@ $$<

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
