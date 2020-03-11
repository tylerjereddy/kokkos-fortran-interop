#!/bin/tcsh
setenv CI_PATH_PREFIX /home/$USER/kokkos-fortran-interop
setenv CI_KOKKOS_PATH /home/$USER/kt/3.0-ppc-xl-16.1.1.6-openmp/lib64/cmake/Kokkos
setenv CI_BUILD_DIR $CI_PATH_PREFIX/ci/build-3.0-ppc-xl-16.1.1.6-openmp
setenv CI_INSTALL_DIR $CI_PATH_PREFIX/ci/install-3.0-ppc-xl-16.1.1.6-openmp
rm -rf $CI_BUILD_DIR
rm -rf $CI_INSTALL_DIR
mkdir -p $CI_BUILD_DIR
mkdir -p $CI_INSTALL_DIR
cd $CI_BUILD_DIR
module load cmake/3.15.3
module load gcc/7.4.0
module load ibm/xlc-16.1.1.6-xlf-16.1.1.6
setenv OMP_NUM_THREADS 4
cmake -DKokkos_DIR=$CI_KOKKOS_PATH \
    -DCMAKE_INSTALL_PREFIX=$CI_INSTALL_DIR $CI_PATH_PREFIX \
    -DCMAKE_Fortran_COMPILER_ARG1=-F/projects/opt/ppc64le/ibm/xlf-16.1.1.6/xlf/16.1.1/etc/xlf.cfg.rhel.7.7.gcc.7.4.0.cuda.10.1 \
    -DCMAKE_CXX_COMPILER_ARG1=-F/projects/opt/ppc64le/ibm/xlc-16.1.1.6/xlC/16.1.1/etc/xlc.cfg.rhel.7.7.gcc.7.4.0.cuda.10.1
cmake --build $CI_BUILD_DIR
cmake --install $CI_BUILD_DIR
ctest