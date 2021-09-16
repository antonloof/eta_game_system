# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# initalize pico_sdk from installed location
# (note this can come from environment, CMake cache etc)
set(PICO_SDK_PATH "C:/Users/Anton/Pico/pico-sdk")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)

project(pico_test C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# Add executable. Default name is the project name, version 0.1
add_executable(pico_test pico_test.c tls3001.c matrix_with_extra.c tetris.c scoreboard.c matrices.c)
pico_generate_pio_header(pico_test ${CMAKE_CURRENT_LIST_DIR}/manchester.pio)
pico_generate_pio_header(pico_test ${CMAKE_CURRENT_LIST_DIR}/seven_segment.pio)

pico_set_program_name(pico_test "pico_test")
pico_set_program_version(pico_test "0.1")

pico_enable_stdio_uart(pico_test 1)
pico_enable_stdio_usb(pico_test 0)

# Add the standard library to the build
target_link_libraries(pico_test pico_stdlib)

# Add any user requested libraries
target_link_libraries(pico_test
        hardware_spi
        hardware_i2c
        hardware_dma
        hardware_pio
        hardware_adc
        )

pico_add_extra_outputs(pico_test)

