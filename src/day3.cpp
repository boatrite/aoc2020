#include <algorithm>
#include <numeric>
#include <iostream>
#include <ranges>
#include <vector>

#include "file.h"

int main() {
  std::vector<std::string> lines = File::readLines("./data/day3.txt");

  std::vector<std::array<int,2>> slopes {
    {1, 1},
    {3, 1},
    {5, 1},
    {7, 1},
    {1, 2}
  };

  auto countTrees = [&lines](std::array<int,2> slope) {
    int dx = slope.at(0);
    int dy = slope.at(1);
    std::string::size_type x { static_cast<std::string::size_type>(dx) };
    std::string::size_type y { static_cast<std::string::size_type>(dy) };
    int trees { 0 };

    while(y < lines.size()) {
      auto line = lines.at(y);
      bool tree_found = line.at(x % line.size()) == '#';

      if (tree_found) {
        trees++;
      }

      x += static_cast<std::string::size_type>(dx);
      y += static_cast<std::string::size_type>(dy);
    }

    // std::cout << trees << std::endl;
    return trees;
  };

  int64_t answer { 1 };
  for (const auto& slope : slopes) {
    answer *= countTrees(slope);
  }
  std::cout << answer << std::endl;

  uint64_t answer2 = std::transform_reduce(
      slopes.begin(), slopes.end(),
      static_cast<uint64_t>(1),
      std::multiplies<>(),
      countTrees
  );
  std::cout << answer2 << std::endl;

  // uint64_t answer3 = std::ranges::transform_reduce(
      // slopes,
      // static_cast<uint64_t>(1),
      // std::multiplies<>(),
      // countTrees
  // );
  // std::cout << answer3 << std::endl;

  return 0;
}

