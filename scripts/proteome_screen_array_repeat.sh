#!/bin/bash

#SBATCH -p gpu_rudner                    # Partition to run in
#SBATCH -A rudner_contrib
#SBATCH --gres=gpu:1                         # GPU resources requested
#SBATCH -c 1                                 # Requested cores
#SBATCH --time=5-00:00                    # Runtime in D-HH:MM format
#SBATCH --mem=32GB      
#SBATCH -o logs/jobs/%A_%a.out                            # File to which STDOUT will be written, including job ID (%A), task ID (%a)
#SBATCH -e logs/jobs/%A_%a.err                           # File to which STDERR will be written, including job ID (%A), task ID (%a)
#SBATCH --mail-type=ALL                      # ALL email notification type
#SBATCH --mail-user=<YOUR_EMAIL_HERE>          # Email to which notifications will be sent
#SBATCH --array=0-15               # Job array indices (for 8 parallel jobs)


module load gcc/14.2.0
module load colabfold

INPUT_DIR="input/repeat_inputs"
INPUT_FILES=(${INPUT_DIR}/*.csv)
INPUT_FILE=${INPUT_FILES[$SLURM_ARRAY_TASK_ID]}

part=$(basename ${INPUT_FILE} .csv)

colabfold_batch --num-recycle 3 \
--model-type auto \
--rank auto \
${INPUT_FILE} \
output/${part}