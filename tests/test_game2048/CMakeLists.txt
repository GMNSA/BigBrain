
cmake_minimum_required(VERSION 3.14)

project(TestGame2048} LANGUAGES CXX)
set(OUT_NAME testGame2048)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_FLAGS "-g3 -Wall -Wextra -Werror")

set(MODEL_GAME_2048_LIB ${CMAKE_CURRENT_SOURCE_DIR}/../../lib)
set(MODEL_GAME_2048_HPP ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/Game2048/includes)

add_compile_definitions(FOR_TEST)

set(HEADERS
    includes/testgame2048.hpp
    )

set(SOURCES
    srcs/testgame2048.cpp
    )


find_package(Qt5 COMPONENTS Core Test REQUIRED)

add_executable(${OUT_NAME} ${SOURCES} ${HEADERS})

add_test(NAME ${OUT_NAME} COMMAND ${OUT_NAME})

enable_testing()


set_target_properties(${OUT_NAME}
        PROPERTIES
        CMAKE_CXX_STANDARD 20
        CMAKE_CXX_STANDARD_REQUIRED ON
        )


target_include_directories(${OUT_NAME}
        PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/includes
		${MODEL_GAME_2048_HPP}
		${MODEL_GAME_2048_LIB}
        )

find_package(game2048)


target_link_libraries(${OUT_NAME}
        PUBLIC
        Qt5::Core
        Qt5::Test
        game2048
        )
