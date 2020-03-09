#!/bin/tcsh
module purge
module load cmake/3.15.3
module load gcc/7.3.0
setenv CI_PATH_PREFIX /home/$USER/kokkos-fortran-interop
setenv CI_KOKKOS_PATH_PREFIX /home/$USER/kt
setenv CI_BUILD_DIR $CI_PATH_PREFIX/ci/build
setenv CI_INSTALL_DIR $CI_PATH_PREFIX/ci/install
mkdir -p $CI_BUILD_DIR
mkdir -p $CI_INSTALL_DIR
## build flcl gnu 7.3.0 + serial
cd $CI_BUILD_DIR
rm -rf $CI_BUILD_DIR/* $CI_INSTALL_DIR/.* $CI_INSTALL_DIR/*
cmake -DKokkos_DIR=$CI_KOKKOS_PATH_PREFIX/3.0-ppc-gnu-7.3.0-serial/lib64/cmake/Kokkos \
    -DCMAKE_INSTALL_PREFIX=$CI_INSTALL_DIR $CI_PATH_PREFIX
cmake --build $CI_BUILD_DIR
cmake --install $CI_BUILD_DIR
# # make test-flcl.x
# # time $HOME/kokkos-fortran-interop/build/test-flcl.x
## build flcl gnu 7.3.0 + openmp
setenv OMP_NUM_THREADS 4
rm -rf $CI_BUILD_DIR/* $CI_INSTALL_DIR/.* $CI_INSTALL_DIR/*
cmake -DKokkos_DIR=$CI_KOKKOS_PATH_PREFIX/3.0-ppc-gnu-7.3.0-openmp/lib64/cmake/Kokkos \
    -DCMAKE_INSTALL_PREFIX=$CI_INSTALL_DIR $CI_PATH_PREFIX
cmake --build $CI_BUILD_DIR
cmake --install $CI_BUILD_DIR
# make test-flcl.x
# time $HOME/kokkos-fortran-interop/build/test-flcl.x
unsetenv OMP_NUM_THREADS
## build flcl gnu 7.3.0 + cuda
module load cuda/10.1
rm -rf $CI_BUILD_DIR/* $CI_INSTALL_DIR/.* $CI_INSTALL_DIR/*
cmake -DKokkos_DIR=$CI_KOKKOS_PATH_PREFIX/3.0-ppc-gnu-7.3.0-cuda-10.1/lib64/cmake/Kokkos \
    -DCMAKE_CXX_COMPILER=/home/$USER/kokkos/kokkos-3.0.00/bin/nvcc_wrapper \
    -DCMAKE_INSTALL_PREFIX=$CI_INSTALL_DIR $CI_PATH_PREFIX
cmake --build $CI_BUILD_DIR
cmake --install $CI_BUILD_DIR
# make test-flcl.x
# time $HOME/kokkos-fortran-interop/build/test-flcl.x
## end gnu section