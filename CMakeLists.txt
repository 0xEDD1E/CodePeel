cmake_minimum_required(VERSION 3.3)
project(CodePeel)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES main.c processfiles.c)
add_executable(CodePeel ${SOURCE_FILES})