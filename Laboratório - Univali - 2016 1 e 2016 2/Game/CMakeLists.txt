cmake_minimum_required(VERSION 3.6)
project(Game1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES  main.cpp map.cpp map.h general.cpp general.h movement.cpp movement.h foes.cpp foes.h)
add_executable(Game1 ${SOURCE_FILES})