#!/bin/bash -l
#SBATCH --partition=defq
#SBATCH --job-name=beaglef3                         # Job name
#SBATCH --mail-type=FAIL                            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=ks575@exeter.ac.uk                  # Where to send mail
#SBATCH --ntasks=1                                      # Run a single task
#SBATCH --cpus-per-task=64                              # Number of CPU cores per task
#SBATCH --mem=2gb                                       # Job memory request
#SBATCH --time=240:05:00                                 # Time limit hrs:min:sec
#SBATCH --output=beaglefmt.tb_%j.log                        # Standard output and error log
#SBATCH --account=c.bass
##
pwd; hostname; date
export OMP_NUM_THREADS=64
pwd; hostname; date
echo "Running a program on $SLURM_JOB_NODELIST"
#/path/to/my/application
echo "Hello $USER, this is running on the $SLURM_CLUSTER_NAME cluster at `hostname` using PI account = $SLURM_JOB_ACCOUNT"
module load slurm/18.08.4 DefaultModules shared Workspace/v1
module load ks575/Angsd/v0.931
work_dir=$WORKSPACE/ANGSD
DATA=$WORKSPACE/bams
REF=$WORKSPACE/Myzus_G006_sorted.FINAL.review.seal.filtered.5k.fasta
all_bam=$work_dir/tobacco.bam.list
##
angsd -b $all_bam -ref $REF -out $work_dir/Results/tobacco -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -minMapQ 20 -minQ 20 -minInd 27 -setMinDepth 15 -doCounts 1 -GL 2 -doGlf 2 -doMajorMinor 1 -r HiC_scaffold_6:57000000-58000000 -doGeno 3 -doPost 2 -doMaf 1
##
##

