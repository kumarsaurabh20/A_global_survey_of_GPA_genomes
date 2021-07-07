#!/bin/bash -l
#SBATCH --partition=hmq
#SBATCH --job-name=decay.ld                        # Job name
#SBATCH --mail-type=FAIL                            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=ks575@exeter.ac.uk                  # Where to send mail
#SBATCH --ntasks=1                                      # Run a single task
#SBATCH --cpus-per-task=5                              # Number of CPU cores per task
#SBATCH --mem=100gb                                       # Job memory request
#SBATCH --time=400:05:00                                 # Time limit hrs:min:sec
#SBATCH --output=decay_ngsld%j.log                        # Standard output and error log
#SBATCH --account=c.bass
##
pwd; hostname; date
export OMP_NUM_THREADS=10
pwd; hostname; date
echo "Running a program on $SLURM_JOB_NODELIST"
#/path/to/my/application
echo "Hello $USER, this is running on the $SLURM_CLUSTER_NAME cluster at `hostname` using PI account = $SLURM_JOB_ACCOUNT"
module load slurm/18.08.4 DefaultModules shared Workspace/v1
module load ks575/R/v4.0.3
##
Rscript --vanilla --slave $NGSLD/scripts/fit_LDdecay.R --ld_files $work_dir/ld.list --out $work_dir/decay.pdf
##

