include(CTest)
enable_testing()

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREAD ON)

find_package(Boost QUIET)

if (Boost_FOUND)
    find_package(Boost REQUIRED COMPONENTS unit_test_framework)
    if (Boost_UNIT_TEST_FRAMEWORK_FOUND)
        include_directories(${Boost_INCLUDE_DIR})
    endif()
endif()

function(add_boost_test TARGET)
    set(TEST_FILES "${ARGN}")

    if (Boost_UNIT_TEST_FRAMEWORK_FOUND)

        foreach(TEST_FILE ${TEST_FILES})

            get_filename_component(TEST_EXECUTABLE_NAME ${TEST_FILE} NAME_WE)

            add_executable(${TEST_EXECUTABLE_NAME} ${TEST_FILE})
            target_link_libraries(${TEST_EXECUTABLE_NAME} ${TARGET} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

            file(READ "${TEST_FILE}" TEST_FILE_CONTENTS)
            string(REGEX MATCHALL "BOOST_AUTO_TEST_CASE\\( *([A-Za-z_0-9]+) *\\)" FOUND_TESTS ${TEST_FILE_CONTENTS})

            foreach(FOUND_TEST ${FOUND_TESTS})
                string(REGEX REPLACE ".*\\( *([A-Za-z_0-9]+) *\\).*" "\\1" TEST_NAME ${FOUND_TEST})

                add_test(
                        NAME "${TEST_EXECUTABLE_NAME}.${TEST_NAME}"
                        COMMAND ${TEST_EXECUTABLE_NAME} --run_test=${TEST_NAME} --catch_system_error=yes
                )
            endforeach()
        endforeach()
    endif()
endfunction()