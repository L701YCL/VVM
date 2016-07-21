#!/bin/sh
#BSUB -a openmpi
#BSUB -n total_cores
#BSUB -q test
#BSUB -o expname.out
#BSUB -e expname.err
#BSUB -J expname
#BSUB -R 'span[ptile=np_threads]'
#BSUB -R "ipathavail==0"

#cd $PBS_O_WORKDIR

export EXPHDR_tmp='expname ../../DATA/expname'

source /pkg/local/Modules/3.2.10/init/sh
module load mpi/intel/2016/openmpi/1.6.5
module load netcdf/4.4.0/intel-2015_hdf5-1.8.16
module load hdf5/1.8.16/intel-2016

export LD_LIBRARY_PATH=/home/j40mog00/petsc360/lib:$LD_LIBRARY_PATH

date > runtime

ldd ./vvm |grep found

mpirun.lsf -np $LSB_DJOB_NUMPROC /project/j40bjt00/VVM/DATA/expname/vvm < INPUT | tee /project/j40bjt00/VVM/DATA/expname/OUTPUT

date >> runtime

