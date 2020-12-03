#include <algorithm>
#include <iostream>
#include <ranges>
#include <vector>

#include "file.h"

// Spent today figuring out ranges stuff and views and a little vim+cpp editor
// integration stuff, and too tired to finish the actual day 2 challenge in cpp.
//
// This doesn't actually compute day 2, but it's a solid working example for
// doing some range stuff :+1:
//
// Hopefully this makes day 3 easier in cpp easier!
int main() {
  std::vector<std::string> lines = File::readLines("./data/day2.txt");

  auto isValid = [](std::string s) {
    return s.size() == 20;
  };

  int numValid = std::ranges::count_if(lines, isValid);

  std::cout << numValid << std::endl;

  return 0;
}
