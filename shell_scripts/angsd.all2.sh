#!/bin/bash -l
#SBATCH --partition=defq
#SBATCH --job-name=beaglefm                         # Job name
#SBATCH --mail-type=FAIL                            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=ks575@exeter.ac.uk                  # Where to send mail
#SBATCH --ntasks=1                                      # Run a single task
#SBATCH --cpus-per-task=64                              # Number of CPU cores per task
#SBATCH --mem=2gb                                       # Job memory request
#SBATCH --time=240:05:00                                 # Time limit hrs:min:sec
#SBATCH --output=beaglefmt.all_%j.log                        # Standard output and error log
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
work_dir=/ANGSD
DATA=bams
REF=Myzus_G006_sorted.FINAL.review.seal.filtered.5k.fasta
all_bam=bam.list
##
angsd -b $all_bam -ref $REF -out $work_dir/Results2/ALL -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -minMapQ 20 -minQ 20 -minInd 120 -setMinDepth 15 -doCounts 1 -GL 2 -doGlf 2 -doMajorMinor 1
##
angsd -glf $work_dir/Results2/ALL.beagle.gz -fai $REF.fai -nInd 128 -out $work_dir/Results2/ALL -doMajorMinor 1 -doGeno 3 -doPost 2 -doMaf 1
##

