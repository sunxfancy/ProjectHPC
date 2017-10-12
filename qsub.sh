
cp -r Project\ 1/ Project1-gcc5.1
cp -r Project\ 1/ Project1-gcc4.7
cp -r Project\ 1/ Project1-gcc4.4

cd Project1-gcc5.1/
module purge
module load gcc-5.1.0
gcc -v
make
qsub jobfile1
qsub jobfile2
cd ..


cd Project1-gcc4.7/
module purge
module load gcc-4.7.1
gcc -v
make
qsub jobfile3
cd ..


cd Project1-gcc4.4/
gcc -v
module purge
make
qsub jobfile4
cd ..

echo finished