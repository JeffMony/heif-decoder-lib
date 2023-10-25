
NDK_ROOT=/Users/jefflee/tools/android-ndk-r14b

CURRENT_DIR=$(pwd)

cd ${CURRENT_DIR}/libde265

ARCH=$1

PREFIX=

HOST=

TARGET=

SYSROOT=

TOOLCHAIN=

API=18

CC=

clean() {
    rm -rf ${CURRENT_DIR}/dist/libde265/*
}

init_arm() {
    HOST=arm-linux-androideabi
    TARGET=arm-linux-androideabi
    SYSROOT=${NDK_ROOT}/platforms/android-${API}/arch-arm
    TOOLCHAIN=${NDK_ROOT}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
    export CC="${TOOLCHAIN}/bin/arm-linux-androideabi-gcc --sysroot=${SYSROOT}"
    export CXX="${TOOLCHAIN}/bin/arm-linux-androideabi-g++ --sysroot=${SYSROOT}"
    PREFIX=${CURRENT_DIR}/dist/libde265/armeabi-v7a

    rm -rf ${PREFIX}
}

init_arm64() {
    HOST=aarch64-linux-android
    TARGET=aarch64-linux-android
    SYSROOT=${NDK_ROOT}/platforms/android-${API}/arch-arm
    TOOLCHAIN=${NDK_ROOT}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64
    export CC="${TOOLCHAIN}/bin/aarch64-linux-android-gcc --sysroot=${SYSROOT}"
    export CXX="${TOOLCHAIN}/bin/aarch64-linux-android-g++ --sysroot=${SYSROOT}"
    PREFIX=${CURRENT_DIR}/dist/libde265/arm64-v8a

    rm -rf ${PREFIX}
}

build() {
    ./configure \
    --disable-dec265 \
    --disable-sherlock265 \
    --prefix=${PREFIX} \
    --host=${HOST} \
    --target=${TARGET} \
    --with-sysroot=${SYSROOT} \
    CPPFLAGS="-I${SYSROOT}/usr/include"

    make clean
    
    make
    
    make install
}

case "${ARCH}" in
    arm)
        init_arm
        build
    ;;
    arm64)
        init_arm64
        build
    ;;
    clean)
         clean
    ;;
esac

cd -