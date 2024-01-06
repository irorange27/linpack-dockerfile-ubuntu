wget http://www.netlib.org/blas/blas-3.11.0.tgz
tar -xzf blas-3.11.0.tgz ; cd BLAS-3.11.0
make -j
ar rv libblas.a *.o
cd ..

wget http://www.netlib.org/blas/blast-forum/cblas.tgz
tar -xzf cblas.tgz ; cd CBLAS
sed -i 's#BLLIB = /Users/julie/Documents/Boulot/lapack-dev/lapack/trunk/blas_LINUX.a#BLLIB = ../BLAS-3.11.0/blas_LINUX.a#g' Makefile.in
make alllib
cd ..
