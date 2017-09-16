function(add_clang_static_analysis TARGET)
    get_target_property(SRCs ${TARGET} SOURCES)
    add_library(${TARGET}_analyze OBJECT EXCLUDE_FROM_ALL ${SRCs})
    set_target_properties(${TARGET}_analyze PROPERTIES
            COMPILE_FLAGS "--analyze -Xanalyzer -analyzer-output=text"
            EXCLUDE_FROM_DEFAULT_BUILD true
            )
endfunction()