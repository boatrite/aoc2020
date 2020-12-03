#pragma once

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include "trim.h"

class File {
  public:
    static std::string read(const std::string path);
    static std::vector<std::string> readLines(const std::string path);
};

std::string File::read(const std::string path) {
  std::string fileContents;
  std::ifstream fileStream;

  // Ensure ifstream objects can throw exceptions
  fileStream.exceptions(std::ifstream::failbit | std::ifstream::badbit);

  try {
    fileStream.open(path);

    std::stringstream stringStream;

    stringStream << fileStream.rdbuf();

    fileStream.close();

    fileContents = stringStream.str();
  } catch (std::ifstream::failure e) {
    std::cerr << "ERROR: File not successfully read. Path: " << path << std::endl;
  }

  return fileContents;
}

std::vector<std::string> File::readLines(const std::string path) {
  std::string input = File::read(path);
  trim(input);
  std::stringstream ss(input);
  std::string to;

  std::vector<std::string> lines {};

  while(std::getline(ss, to, '\n')) {
    lines.push_back(to);
  }

  return lines;
}
