function(find_boost boost_VERSION boost_MD5)
    set(boost_COMPONENTS "${ARGN}")

    find_package(Boost ${boost_VERSION} QUIET)

    if (Boost_FOUND)
        find_package(Boost ${boost_VERSION} REQUIRED COMPONENTS "${boost_COMPONENTS}")
    else()

        message("** Boost not found, will download and use external Boost")

        include(ExternalProject)

        string(REPLACE "." "_" boost_VERSION_U ${boost_VERSION})
        set(boost_URL "http://sourceforge.net/projects/boost/files/boost/${boost_VERSION}/boost_${boost_VERSION_U}.tar.bz2")
        set(boost_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/third_party/boost)
        set(boost_INCLUDE_DIR ${boost_INSTALL}/include)
        set(boost_LIB_DIR ${boost_INSTALL}/lib)

        foreach(COMPONENT ${boost_COMPONENTS})
            set(boost_CONFIGURE_COMMAND_WITH_LIB
                    ${boost_CONFIGURE_COMMAND_WITH_LIB}
                    --with-libraries=${COMPONENT}
                    )
            set(boost_LIBRARIES
                    ${boost_LIBRARIES}
                    ${boost_LIB_DIR}/libboost_${COMPONENT}.a
                    )
        endforeach()

        ExternalProject_Add(external_boost
                PREFIX boost
                URL ${boost_URL}
                URL_HASH MD5=${boost_MD5}
                BUILD_IN_SOURCE 1
                CONFIGURE_COMMAND
                ./bootstrap.sh
                ${boost_CONFIGURE_COMMAND_WITH_LIB}
                --prefix=<INSTALL_DIR>
                BUILD_COMMAND
                ./b2 install link=static variant=release threading=multi runtime-link=static
                INSTALL_COMMAND ""
                INSTALL_DIR ${boost_INSTALL}
                )
    endif()
endfunction()

function(target_link_boost TARGET)
    if (TARGET external_boost)
        add_dependencies(${TARGET} external_boost)
    endif()
    target_link_libraries(${TARGET} ${boost_LIBRARIES})
endfunction()