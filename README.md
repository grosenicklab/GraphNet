## GRAPHNET for graph-regularized sparse regression and classification in high dimensions. 

This Pythonic and Cythonic code is an in-progress rehabilitation of the original code that implements the algorithms discussed in 

https://www.sciencedirect.com/science/article/pii/S1053811912012487

Although examples should run, additional improvements to performance are in progress.

## Installation 

To compile the necessary cython modules to run Graphnet, first run

python setup.py build_ext --inplace

from the Graphnet/code directory.

## Usage

See examples in code/examples.py

### Authors 

Logan Grosenick (log4002@med.cornell.edu)

Brad Klingenberg

Jonathan Taylor (jonathan.taylor@stanford.edu)
