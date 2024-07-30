# A simple toolchain for Unreal Engine4 Linxu Compile toolchain

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(UNIX 1)

# string (REPLACE "\\" "/" CLANG_MULTIARCH_ROOT "$ENV{LINUX_MULTIARCH_ROOT}")
message(STATUS "Path <$ENV{LINUX_MULTIARCH_ROOT}>")
set (CLANG_MULTIARCH_ROOT "$ENV{LINUX_MULTIARCH_ROOT}")
set(LINUX_ARCH_NAME "${CMAKE_SYSTEM_PROCESSOR}-unknown-linux-gnu")

set(CLANG_TOOLCHAIN_ROOT "${CLANG_MULTIARCH_ROOT}/${LINUX_ARCH_NAME}")
if (NOT EXISTS "${CLANG_TOOLCHAIN_ROOT}")
	message(FATAL_ERROR "Path <${CLANG_TOOLCHAIN_ROOT}> does not exist")
endif()
message(STATUS "clang tool chain path: ${CLANG_TOOLCHAIN_ROOT}")
set(CLANG_TOOLCHAIN_BIN "${CLANG_TOOLCHAIN_ROOT}/bin")

message(STATUS "Configuring UE5 Linux native toolchain")

# =============================================================================
# Set file suffixes/prefixes
# =============================================================================
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_STATIC_LIBRARY_SUFFIX_CXX ".a")

# =============================================================================
# Define cmake behaviors
# =============================================================================
set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CMAKE_FIND_ROOT_PATH ${CLANG_TOOLCHAIN_ROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Optionally reduce compiler sanity check when cross-compiling.
# set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# =============================================================================
# Define tool paths
# =============================================================================
set(CMAKE_C_COMPILER	${CLANG_TOOLCHAIN_BIN}/clang 							CACHE PATH "compiler" FORCE)
set(CMAKE_CXX_COMPILER	${CLANG_TOOLCHAIN_BIN}/clang++							CACHE STRING "" FORCE)
set(CMAKE_ASM_COMPILER	${CMAKE_C_COMPILER}										CACHE STRING "" FORCE)
set(CMAKE_AR 			${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-ar		CACHE PATH "archive")
set(CMAKE_RANLIB		${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-ranlib	CACHE PATH "ranlib")
set(CMAKE_LINKER 		${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-ld		CACHE PATH "linker")
set(CMAKE_NM 			${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-gcc-nm	CACHE PATH "nm")
set(CMAKE_OBJCOPY 		${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-objcopy	CACHE PATH "objcopy")
set(CMAKE_OBJDUMP 		${CLANG_TOOLCHAIN_BIN}/x86_64-unknown-linux-gnu-objdump	CACHE PATH "objdump")


# =============================================================================
# Define flags 
# =============================================================================
set(CMAKE_SYSROOT 		 "${CLANG_TOOLCHAIN_ROOT}")
set(COMPILER_FLAGS 		 " --target=${LINUX_ARCH_NAME} -std=c++17 -fno-math-errno -fno-rtti -fno-exceptions -funwind-tables -gdwarf-3 -fPIC -stdlib=libc++")
set(FLAGS_DEBUG 		 " -O0 -g -D_DEBUG")
set(FLAGS_MINSIZEREL 	 " -Os -DNDEBUG")
set(FLAGS_RELEASE 		 " -O3 -DNDEBUG")
set(FLAGS_RELWITHDEBINFO " -O3 -g -D_DEBUG")

# =============================================================================
# Define include paths
# =============================================================================
set(CMAKE_SYSTEM_INCLUDE_PATH "")
set(CMAKE_INCLUDE_PATH	"")

include_directories("${UE_THIRD_PARTY_PATH}/Unix/LibCxx/include/c++/v1/")
include_directories("${UE_THIRD_PARTY_PATH}/Unix/LibCxx/include/")
include_directories("${CLANG_TOOLCHAIN_ROOT}/usr/include")


# =============================================================================
# Set compiler flags
# =============================================================================	
string(CONCAT CMAKE_CXX_FLAGS					"${CMAKE_CXX_FLAGS_INIT}			${COMPILER_FLAGS} -I${CLANG_TOOLCHAIN_ROOT}/usr/include -I${UE_THIRD_PARTY_PATH}/Unix/LibCxx/include/c++/v1/ -I${UE_THIRD_PARTY_PATH}/Unix/LibCxx/include/")
string(CONCAT CMAKE_CXX_FLAGS_DEBUG				"${CMAKE_CXX_FLAGS_DEBUG_INIT}			${FLAGS_DEBUG}")
string(CONCAT CMAKE_CXX_FLAGS_MINSIZEREL		"${CMAKE_CXX_FLAGS_MINSIZEREL_INIT} 	${FLAGS_MINSIZEREL}")
string(CONCAT CMAKE_CXX_FLAGS_RELEASE			"${CMAKE_CXX_FLAGS_RELEASE_INIT}		${FLAGS_RELEASE}")
string(CONCAT CMAKE_CXX_FLAGS_RELWITHDEBINFO	"${CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT}	${FLAGS_RELWITHDEBINFO}")

string(CONCAT CMAKE_C_FLAGS					"${CMAKE_C_FLAGS_INIT}				${COMPILER_FLAGS}")
string(CONCAT CMAKE_C_FLAGS_DEBUG			"${CMAKE_C_FLAGS_DEBUG_INIT}			${FLAGS_DEBUG}")
string(CONCAT CMAKE_C_FLAGS_MINSIZEREL		"${CMAKE_C_FLAGS_MINSIZEREL_INIT}		${FLAGS_MINSIZEREL}")
string(CONCAT CMAKE_C_FLAGS_RELEASE			"${CMAKE_C_FLAGS_RELEASE_INIT}			${FLAGS_RELEASE}")
string(CONCAT CMAKE_C_FLAGS_RELWITHDEBINFO	"${CMAKE_C_FLAGS_RELWITHDEBINFO_INIT}	${FLAGS_RELWITHDEBINFO}")

## set linker flags
# SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -v -nodefaultlibs -L ${UE_THIRD_PARTY_PATH}/Unix/LibCxx/lib/Unix/x86_64-unknown-linux-gnu/ ${UE_THIRD_PARTY_PATH}/Unix/LibCxx/lib/Unix/x86_64-unknown-linux-gnu/libc++.a ${UE_THIRD_PARTY_PATH}/Unix/LibCxx/lib/Unix/x86_64-unknown-linux-gnu/libc++abi.a -lm -lc -lpthread -pthread")

set(CMAKE_CXX_CREATE_STATIC_LIBRARY	"<CMAKE_AR> rcs <TARGET> <LINK_FLAGS> <OBJECTS>" CACHE STRING "" FORCE)

