apt -y install git
git clone https://github.com/hpcg-benchmark/hpcg.git
cd hpcg
sed -i 's#MPdir        =#MPdir        = /usr/local#g' setup/Make.Linux_MPI
sed -i 's#CXX          = mpicxx#CXX          = /usr/local/bin/mpicxx#g' setup/Make.Linux_MPI
mkdir build ; cd build
../configure Linux_MPI
../configure Linux_MPI
make 
mpirun -np 8 bin/xhpcg
