cmake_minimum_required(VERSION 3.16)

project(fig_03_11 C ASM)

set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -m32")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -m32")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -m32")

include_directories(${CMAKE_SOURCE_DIR}/include)

add_executable(fig_03_11
    src/example.s
    src/io.s
    src/framework.c
)

