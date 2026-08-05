#!/bin/bash

#SBATCH --account=rudner
#SBATCH -p short  
#SBATCH --time=0-00:15                    # Runtime in D-HH:MM format
#SBATCH -c 20
#SBATCH --mem=8GB      
#SBATCH -o logs/jobs/%j.out                            # File to which STDOUT will be written, including job ID (%j)
#SBATCH -e logs/jobs/%j.err                            # File to which STDERR will be written, including job ID (%j)
#SBATCH --mail-type=ALL                      # ALL email notification type
#SBATCH --mail-user=<YOUR_EMAIL_HERE>          # Email to which notifications will be sent

module load conda/miniforge3/24.11.3-0

conda activate af2-multimer-analysis

cd analysis/

python3 $HOME/AF2multimer-analysis/colabfold_analysis.py ../output/part_1 ../output/part_2 ../output/part_3 ../output/part_4 ../output/part_5 ../output/part_6 ../output/part_7 ../output/part_8 ../output/part_9 ../output/part_10 ../output/part_11 ../output/part_12 ../output/part_13 ../output/part_14 ../output/part_15 ../output/part_16  --pae 12 --plddt 50 --pae-mode avg --combine-all 

conda deactivate