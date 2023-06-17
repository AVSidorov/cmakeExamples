set(lib_name print)
function(findOrCompile lib_name lib_path)
    target_include_directories(${PROJECT_NAME} PUBLIC ${lib_path}/src)
    find_library(${lib_name}_lib
        NAMES "lib${lib_name}.a"
              ${lib_name}.lib
              ${lib_name}.so
              ${lib_name}
              ${lib_name}.dll
        PATHS ${lib_path}
        PATH_SUFFIXES build/
    )
    message("${lib_name}_lib = ${${lib_name}_lib}")
    if(${lib_name}_lib STREQUAL "${lib_name}_lib-NOTFOUND")
        message("${lib_name} NOT FOUND")

        #add_subdirectory(${lib_path} ${lib_path}/build)
        try_compile(
            ${lib_name}_build
            ${lib_path}/build ${lib_path}
            ${lib_name}
        )
        message("${lib_name}_build = ${${lib_name}_build}")
        target_link_libraries(${PROJECT_NAME} PUBLIC ${lib_name})
    else()
        message("${lib_name} FOUND")
        target_link_libraries(${PROJECT_NAME} PUBLIC ${${lib_name}_lib})
    endif()
endfunction()