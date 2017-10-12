
cp -r Project\ 1/ Project1-gcc5.1
cp -r Project\ 1/ Project1-gcc4.7
cp -r Project\ 1/ Project1-gcc4.4

cd Project1-gcc5.1/
make
qsub jobfile1
qsub jobfile2
cd ..


cd Project1-gcc4.7/
make
qsub jobfile3
cd ..


cd Project1-gcc4.4/
make
qsub jobfile4
cd ..

echo finished