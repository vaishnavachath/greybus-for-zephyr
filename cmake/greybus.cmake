#
# Copyright (c) 2020 Friedt Professional Engineering Services, Inc
#
# SPDX-License-Identifier: Apache-2.0

if(NOT(DEFINED ENV{G4Z_DIR}))
  message(FATAL_ERROR "Environment variable G4Z_DIR is not defined")
endif()

set(G4Z_DIR ENV{G4Z_DIR})

function(gen_greybus_manifest)
  add_custom_command(
    OUTPUT ${generated_file}
    COMMAND
    ${PYTHON_EXECUTABLE}
    ${G4Z_DIR}/scripts/dts_to_mnfs.py
    ${ARGN} # Extra arguments are passed to dts_to_mnfs.py
    --file ${source_file}
    > ${generated_file}
    DEPENDS ${source_file}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endfunction()

function(mnfs_to_mnfb
    source_file    # The source file to be converted to hex
    generated_file # The generated file
    )
  add_custom_command(
    OUTPUT ${generated_file}
    COMMAND
    ${PYTHON_EXECUTABLE}
    ${G4Z_DIR}/scripts/manifesto
    ${ARGN} # Extra arguments are passed to dts_to_mnfs.py
    ${source_file}
    -o ${generated_file}
    DEPENDS ${source_file}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endfunction()

