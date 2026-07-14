#!/bin/bash

#SBATCH --account=rudner
#SBATCH -p short  
#SBATCH --time=0-00:15                    # Runtime in D-HH:MM format
#SBATCH -c 20
#SBATCH --mem=8GB      
#SBATCH -o logs/jobs/%j.out                            # File to which STDOUT will be written, including job ID (%j)
#SBATCH -e logs/jobs/%j.err                            # File to which STDERR will be written, including job ID (%j)
#SBATCH --mail-type=ALL                      # ALL email notification type
#SBATCH --mail-user=<james_warner@hms.harvard.edu>          # Email to which notifications will be sent

module load conda/miniforge3/24.11.3-0

conda activate af2-multimer-analysis

cd /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/analysis/

python3 /home/jw362/AF2multimer-analysis/colabfold_analysis.py /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_1 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_2 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_3 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_4 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_5 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_6 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_7 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_8 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_9 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_10 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_11 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_12 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_13 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_14 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_15 /n/data1/hms/microbiology/rudner/lab/jw362/colabfold/SaPBP2/output/part_16  --pae 12 --plddt 50 --pae-mode avg --combine-all 

conda deactivate