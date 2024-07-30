#[[

  Copyright (c) 2024 Computer Vision Center (CVC) at the Universitat Autonoma
  de Barcelona (UAB).
  
  This work is licensed under the terms of the MIT license.
  For a copy, see <https://opensource.org/licenses/MIT>.

]]

set (UE_ROOT $ENV{UE_ROOT})

if (NOT UE_ROOT)
	set (UE_ROOT $ENV{UE_ROOT})
endif ()

if ("${UE_ROOT}" STREQUAL "")
	set (UE_ROOT ${UE_ROOT})
	set (ENV{UE_ROOT} ${UE_ROOT}) # @TODO
endif ()

if (NOT EXISTS ${UE_ROOT})
	message (FATAL_ERROR "The specified Carla Unreal Engine 5 path does not exist (\"${UE_ROOT}\").")
endif ()

set (ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR})

if	(${ARCH} STREQUAL "x86_64")
	set	(CMAKE_SYSTEM_PROCESSOR x86_64 CACHE STRING "")
	set	(TARGET_TRIPLE "x86_64-unknown-linux-gnu" CACHE STRING "")
elseif (${ARCH} STREQUAL "aarch64")
	set (CMAKE_SYSTEM_PROCESSOR aarch64 CACHE STRING "")
	set (TARGET_TRIPLE "aarch64-unknown-linux-gnueabi" CACHE STRING "")
endif()

set (
	UE_SYSROOT
	${UE_ROOT}/Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v22_clang-16.0.6-centos7/${TARGET_TRIPLE}
	CACHE PATH ""
)

set (
	UE_THIRD_PARTY
	${UE_ROOT}/Engine/Source/ThirdParty CACHE PATH ""
)

set (
	UE_INCLUDE
	${UE_THIRD_PARTY}/Unix/LibCxx/include CACHE PATH ""
)

set (
	UE_LIBS
	${UE_THIRD_PARTY}/Unix/LibCxx/lib/Unix/${TARGET_TRIPLE} CACHE PATH ""
)

add_compile_options (
    # -fno-rtti 
    # -fno-exceptions 
    # -funwind-tables 
    # -gdwarf-3 
    -fPIC
	# -fms-extensions
	-fno-math-errno
	-fdiagnostics-absolute-paths
	$<$<COMPILE_LANGUAGE:CXX>:-stdlib=libc++>
)

add_link_options (-stdlib=libc++ -L${UE_LIBS} )

set(CMAKE_SYSROOT ${UE_SYSROOT})
set(CMAKE_FIND_ROOT_PATH ${UE_SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set (
	CMAKE_AR
	${UE_SYSROOT}/bin/llvm-ar
	CACHE FILEPATH ""
)

set (
	CMAKE_ASM_COMPILER
	${UE_SYSROOT}/bin/clang
	CACHE FILEPATH ""
)

set (
	CMAKE_C_COMPILER
	${UE_SYSROOT}/bin/clang
	CACHE FILEPATH ""
)

set (
	CMAKE_C_COMPILER_AR
	${UE_SYSROOT}/bin/llvm-ar
	CACHE FILEPATH ""
)

set (
	CMAKE_CXX_COMPILER
	${UE_SYSROOT}/bin/clang++
	CACHE FILEPATH ""
)

set (
	CMAKE_CXX_COMPILER_AR
	${UE_SYSROOT}/bin/llvm-ar
	CACHE FILEPATH ""
)

set (
	CMAKE_OBJCOPY
	${UE_SYSROOT}/bin/llvm-objcopy
	CACHE FILEPATH ""
)

set (
	CMAKE_ADDR2LINE
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-addr2line
	CACHE FILEPATH ""
)

set (
	CMAKE_C_COMPILER_RANLIB
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-ranlib
	CACHE FILEPATH ""
)

set (
	CMAKE_CXX_COMPILER_RANLIB
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-ranlib
	CACHE FILEPATH ""
)

set (
	CMAKE_LINKER
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-ld
	CACHE FILEPATH ""
)

set (
	CMAKE_NM
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-nm
	CACHE FILEPATH ""
)

set (
	CMAKE_OBJDUMP
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-objdump
	CACHE FILEPATH ""
)

set (
	CMAKE_RANLIB
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-ranlib
	CACHE FILEPATH ""
)

set (
	CMAKE_READELF
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-readelf
	CACHE FILEPATH ""
)

set (
	CMAKE_STRIP
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-strip
	CACHE FILEPATH ""
)

set (
	COVERAGE_COMMAND
	${UE_SYSROOT}/bin/${TARGET_TRIPLE}-gcov
	CACHE FILEPATH ""
)

set (
	CMAKE_CXX_STANDARD_LIBRARIES
	"${UE_LIBS}/libc++.a ${UE_LIBS}/libc++abi.a"
)

set (
	CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES
	${UE_INCLUDE} ${UE_INCLUDE}/c++/v1
)