#include <iostream>
#include <vector>

#include "file.h"
#include "trim.h"

int main() {
  std::string input = File::read("./data/day1.txt");
  trim(input);
  std::stringstream ss(input);
  std::string to;

  std::vector<int> integers {};

  while(std::getline(ss, to, '\n')) {
    int x = std::stoi(to);
    integers.push_back(x);
  }

  for (auto i = 0; i < integers.size(); ++i) {
    for (auto j = i+1; j < integers.size(); ++j) {
      for (auto k = j+1; k < integers.size(); ++k) {
        int x = integers[i];
        int y = integers[j];
        int z = integers[k];
        if (x + y + z == 2020) {
          std::cout << "x: " << x << ", y: " << y << ", z: " << z << ", x*y*z: " << x*y*z << std::endl;
          return 0;
        }
      }
    }
  }

  return 0;
}
