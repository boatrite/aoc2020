#include <algorithm>
#include <numeric>
#include <iostream>
#include <ranges>
#include <vector>

#include "string_helper.h"
#include "file.h"

int main() {
  std::string input = File::read("./data/day4.txt");
  std::vector<std::string> batches = StringHelper::split(input, "\n\n");

  std::vector<std::string> passports {};
  std::transform(batches.begin(), batches.end(), std::back_inserter(passports), [](const std::string& batch) {
      std::string s = StringHelper::join(StringHelper::split(batch, "\n"), " ");
      return s;
  });

  int answer { 0 };

  for (const auto& passport : passports) {
  }

  std::cout << passports.at(3) << std::endl;
  return 0;
}
