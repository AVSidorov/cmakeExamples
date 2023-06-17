cmake_minimum_required(VERSION 3.22)

project(print LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(allFiles
    ${CMAKE_CURRENT_LIST_DIR}/src/print.h
    ${CMAKE_CURRENT_LIST_DIR}/src/print.cpp
)

add_library(${PROJECT_NAME} ${allFiles})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src)

include(../funcs.cmake)
findOrCompile(hello ${CMAKE_CURRENT_LIST_DIR}/../core)