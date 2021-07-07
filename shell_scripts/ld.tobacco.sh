#!/bin/bash -l
#SBATCH --partition=hmq
#SBATCH --job-name=LD.tobacco                        # Job name
#SBATCH --mail-type=FAIL                            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=ks575@exeter.ac.uk                  # Where to send mail
#SBATCH --ntasks=1                                      # Run a single task
#SBATCH --cpus-per-task=64                              # Number of CPU cores per task
#SBATCH --mem=2gb                                       # Job memory request
#SBATCH --time=240:05:00                                 # Time limit hrs:min:sec
#SBATCH --output=ld.tb_chr4_ld%j.log                        # Standard output and error log
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
work_dir=$WORKSPACE/Data/Myzus/Myzus_mapping/Trimmed_Resequencing_Data_18_03_2019/ANGSD
DATA=$WORKSPACE/Data/Myzus/Myzus_mapping/Trimmed_Resequencing_Data_18_03_2019/bams
REF=$WORKSPACE/Data/Myzus/Myzus_mapping/genome/Myzus_G006_sorted.FINAL.review.seal.filtered.5k.fasta
all_bam=$work_dir/tobacco.bam.list
results=$work_dir/Results3
##
angsd -b $all_bam -ref $REF -out $work_dir/Results3/tobacco -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -minMapQ 20 -minQ 20 -minInd 27 -setMinDepth 15 -doCounts 1 -GL 2 -doGlf 2 -doMajorMinor 1 -r HiC_scaffold_4:44720000-44728000 -doGeno 3 -doPost 2 -doMaf 1
##
NGSLD=/nobackup/beegfs/workspace/ks575/Data/Myzus/Myzus_mapping/Trimmed_Resequencing_Data_18_03_2019/ANGSD/Tools/ngsLD
$NGSLD/ngsLD --geno $results/tobacco.beagle.gz --pos $results/tobacco.pos.gz --probs --n_ind 27 --n_sites 7793 --max_kb_dist 0 --n_threads 64 --out $results/tobacco.ld
##

