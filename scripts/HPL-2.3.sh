cp CBLAS/lib/* /usr/local/lib
cp BLAS-3.11.0/blas_LINUX.a /usr/local/lib
wget http://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz
tar -xzf hpl-2.3.tar.gz ; cd hpl-2.3
cp setup/Make.Linux_PII_CBLAS ./
cp include/* /usr/local/include
sed -i "s/arch             = UNKNOWN/arch             = Linux_PII_CBLAS/g" Makefile
sed -i 's#TOPdir       = \$(HOME)/hpl#TOPdir       = /home/hpl-2.3#g' Make.Linux_PII_CBLAS
sed -i 's#MPdir        = /usr/local/mpi#MPdir        = /usr/local#g' Make.Linux_PII_CBLAS
sed -i 's#MPlib        = \$(MPdir)/lib/libmpich.a#MPlib        = \$(MPdir)/lib/libmpich.so#g' Make.Linux_PII_CBLAS
sed -i 's#LAdir        = \$(HOME)/netlib/ARCHIVES/Linux_PII#LAdir        = /usr/local/lib#g' Make.Linux_PII_CBLAS
sed -i 's#LAlib        = \$(LAdir)/libcblas.a \$(LAdir)/libatlas.a#LAlib        = \$(LAdir)/cblas_LINUX.a \$(LAdir)/blas_LINUX.a#g' Make.Linux_PII_CBLAS
sed -i 's#CC           = /usr/bin/gcc#CC           = /usr/local/bin/mpicc#g' Make.Linux_PII_CBLAS
sed -i 's#LINKER       = /usr/bin/g77#LINKER       = /usr/local/bin/mpif77#g' Make.Linux_PII_CBLAS

make -j arch=Linux_PII_CBLAS
cd bin/Linux_PII_CBLAS
# mpirun -np 4 ./xhpl > HPL-Benchmark.txt
