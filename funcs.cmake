function(findOrCompile lib_name lib_path)
    cmake_path(SET lib_path NORMALIZE ${lib_path})
    cmake_path(RELATIVE_PATH CMAKE_CURRENT_BINARY_DIR
            OUTPUT_VARIABLE build_suffix
    )

    message("${PROJECT_NAME} searches ${lib_name} in ${lib_path}")

    target_include_directories(${PROJECT_NAME} PUBLIC ${lib_path}/src)
    find_library(${lib_name}_lib
        NAMES "lib${lib_name}.a"
              ${lib_name}.lib
              ${lib_name}.so
              ${lib_name}
              ${lib_name}.dll
        PATHS ${lib_path}
            ${CMAKE_INSTALL_PREFIX}
        PATH_SUFFIXES build/
                        cmake-build/
                        ${build_suffix}/
                        lib/
    )
    message("${lib_name}_lib = ${${lib_name}_lib}")
    if(${lib_name}_lib STREQUAL "${lib_name}_lib-NOTFOUND")
        message("${lib_name} NOT FOUND")

        #add_subdirectory(${lib_path} ${lib_path}/build)
        try_compile(
            ${lib_name}_build
            ${lib_path}/${build_suffix} ${lib_path}
            ${lib_name}
                ${lib_name}
        )
        if(${${lib_name}_build})
            execute_process(COMMAND {CMAKE_COMMAND} --install ${lib_path}/${build_suffix})
            findOrCompile(${lib_name} ${l`ib_path})
        else()
            message(FATAL_ERROR "${lib_name} neither found nor compiled. Exit")
        endif()
    else()
        message("${lib_name} FOUND")
        target_link_libraries(${PROJECT_NAME} PUBLIC ${${lib_name}_lib})
    endif()
endfunction()