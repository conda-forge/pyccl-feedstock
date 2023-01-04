ln -s ${BUILD_PREFIX}/bin/swig ${PREFIX}/bin/swig

pyver=$($PYTHON --version)
pyver=${pyver//Python /}

mkdir -p build

cmake ${CMAKE_ARGS} \
    -H. \
    -Bbuild \
    -DPYTHON_VERSION=${pyver} \
    -DCMAKE_VERBOSE_MAKEFILE=ON

pushd build
make VERBOSE=1 _ccllib
popd

${PYTHON} -m pip install . -vv

rm -f ${PREFIX}/bin/swig
