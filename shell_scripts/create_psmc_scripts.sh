#!/bin/bash
clear
file_dir=/nobackup/beegfs/workspace/ks575/Data/Myzus/Myzus_mapping/Trimmed_Resequencing_Data_18_03_2019
work_dir=/nobackup/beegfs/workspace/ks575/Data/Myzus/Myzus_mapping/Trimmed_Resequencing_Data_18_03_2019/VCF/final/filtering/PSMC
##edit this line to specify filter
scripts=$work_dir/scripts

OIFS=$IFS; IFS=$'\n'; LINES=($(<$file_dir/psmc.jobs)); IFS=$OIFS
i=1
NSLOTS=1
for LINE in "${LINES[@]}"
do
echo $LINE
cat << EOF > $scripts/jobs_batch${i}.sh
#!/bin/bash -l
#SBATCH --partition=hmq
#SBATCH --job-name=psmc$i
#SBATCH --mail-type=FAIL 
#SBATCH --mail-user=ks575@exeter.ac.uk
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=${NSLOTS}
#SBATCH --mem=10gb
#SBATCH --time=240:05:00
#SBATCH --output=psmc${i}_parallel_%j.log
#SBATCH --account=c.bass
##
pwd; hostname; date
export OMP_NUM_THREADS=$NSLOTS
pwd; hostname; date
echo "Running a program on $SLURM_JOB_NODELIST"
##
#/path/to/my/application
echo "Hello \$USER, this is running on the \$SLURM_CLUSTER_NAME cluster at \`hostname\` using PI account = \$SLURM_JOB_ACCOUNT"
module load DefaultModules shared Workspace/v1 slurm/18.08.4  Conda/Python2/2.7.15 ks575/BioPython/v1.74 VCFtools/0.1.16 ActivePerl/5.24.3.2404 bcftools/1.9 samtools/1.9
$LINE
EOF

((i++))
done
