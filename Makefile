#
# Compiler flags
#
CC = g++
CFLAGS = -std=c++17 \
				 -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion

build/day1: src/day1.cpp | build
	$(CC) -o $@ $<

build:
	mkdir -p build
