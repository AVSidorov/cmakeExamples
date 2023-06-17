cmake_minimum_required(VERSION 3.22)


project(app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_INSTALL_PREFIX ../dist/${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}-${CMAKE_CXX_COMPILER_ID}/)

set(allFiles
    ${CMAKE_CURRENT_LIST_DIR}/src/main.cpp
)

add_executable(${PROJECT_NAME} ${allFiles})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src)

include(../funcs.cmake)
findOrCompile(hello ${CMAKE_CURRENT_LIST_DIR}/../core)
findOrCompile(print ${CMAKE_CURRENT_LIST_DIR}/../second)

include(GNUInstallDirs)

install(TARGETS ${PROJECT_NAME}
        EXPORT core
        RUNTIME_DEPENDENCY_SET core_rt
)

install(IMPORTED_RUNTIME_ARTIFACTS ${PROJECT_NAME}
        RUNTIME_DEPENDENCY_SET core_rt_art)
#install(EXPORT core
#        DESTINATION export/
#)
install(RUNTIME_DEPENDENCY_SET core_rt)
install(RUNTIME_DEPENDENCY_SET core_rt_art)
