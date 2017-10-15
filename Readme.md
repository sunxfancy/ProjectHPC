Project 1
==============

This is the test code for our project 1 in HPC class.

Support enviorment: Linux & MacOSX

## File Structure

`Project 1` is the main directory for the project. For supporting multiple gcc versions, I copy the code to different directories and build in those pathes. 

There are four jobfile for running the code on our cluster. 

`qsub.sh` is a convenient shell script to submit all of tasks. 


## Build

Run `make` in the build path, such as `./Project1-gcc4.4`. 
You can also run `make p1-O1` in those directories, that will generate the different version code for testing.

The program `p1` is for the first part, using register reuse to optimize.
The program `p2` used the cache reuse and blocking, also has a mixed version which has the best performance.

## Testing

Run `test` for full test in one of the verison of the code.

There are some args are quite important for `p2` program.

First argument is a number, that's used for the test scale. To meet our requirements, 2048 should be passed. The second argument is `-N` or null, if this argument is null, the program will try to find a block size for best performance.

