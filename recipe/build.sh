ln -s ${BUILD_PREFIX}/bin/swig ${PREFIX}/bin/swig

export CFLAGS="${CFLAGS} -Wno-int-conversion"

pyver=$($PYTHON --version)
pyver=${pyver//Python /}
pyver=$(echo ${pyver} | cut -d "r" -f 1)

mkdir -p build

cmake ${CMAKE_ARGS} \
    -H. \
    -Bbuild \
    -DPYTHON_VERSION=${pyver} \
    -DFORCE_OPENMP=YES \
    -DCMAKE_VERBOSE_MAKEFILE=ON

pushd build
make VERBOSE=1 _ccllib
popd

${PYTHON} -m pip install . -vv

rm -f ${PREFIX}/bin/swig
