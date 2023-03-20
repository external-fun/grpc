#
# Dependencies
#
find_package(Threads)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lsqlite3")

#
# Sources
#
set(SOURCES
    src/main.cpp
)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES})

include_directories(${SQLite3_INCLUDE_DIRS})

#
# Target
#
add_executable(client ${SOURCES})

target_link_libraries(client
  myproto
  ${SQLite3_LIBRARIES}
)