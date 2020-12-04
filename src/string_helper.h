#pragma once

#include <string>
#include <vector>

class StringHelper {
  public:
    static std::vector<std::string> split(const std::string& str, const std::string& delim);
    static std::string join(const std::vector<std::string>& strs, const std::string& delim);
};

std::vector<std::string> StringHelper::split(const std::string& str, const std::string& delim) {
  size_t start {};
  size_t end { 0 };

  std::vector<std::string> out;

  while ((start = str.find_first_not_of(delim, end)) != std::string::npos)
  {
    end = str.find(delim, start);
    out.push_back(str.substr(start, end - start));
  }

  return out;
}

std::string StringHelper::join(const std::vector<std::string>& strs, const std::string& delim) {
  std::string out {};

  for (std::vector<std::string>::const_iterator p = strs.begin(); p != strs.end(); ++p) {
    out += *p;
    if (p != strs.end() - 1)
      out += delim;
  }

  return out;
}
