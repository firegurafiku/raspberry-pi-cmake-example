SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)

set(toolchain "$ENV{RPI_TOOLCHAIN_PATH}")

if(RPI_TOOLCHAIN_PATH)
  set(toolchain "${RPI_TOOLCHAIN_PATH}")
endif()

if(NOT toolchain)
  message(FATAL_ERROR "Path to GNU toolchain for arm is not known. Please, "
                      "set either RPI_TOOLCHAIN or ENV{RPI_TOOLCHAIN}.")
endif()

set(root "$ENV{RPI_RASPBIAN_ROOT}")
if(PRI_RASPBIAN_ROOT)
  set(root "${RPI_RASPBIAN_ROOT}")
endif()

if(NOT root)
  message(FATAL_ERROR "Path tor root!")
endif()

SET(CMAKE_C_COMPILER   "${toolchain}/arm-linux-gnueabihf-gcc")
SET(CMAKE_CXX_COMPILER "${toolchain}/arm-linux-gnueabihf-g++")
SET(CMAKE_FIND_ROOT_PATH "${root}")
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_SYSROOT "${root}")
#list(APPEND CMAKE_SYSTEM_LIBRARY_PATH "${root}/lib")
#list(APPEND CMAKE_SYSTEM_LIBRARY_PATH "${root}/usr/lib")

