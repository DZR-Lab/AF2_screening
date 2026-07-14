#!/bin/bash

#SBATCH --account=rudner
#SBATCH -p short  
#SBATCH --time=0-00:01                    # Runtime in D-HH:MM format
#SBATCH -c 1
#SBATCH --mem=20K      
#SBATCH -o logs/jobs/%j.out                            # File to which STDOUT will be written, including job ID (%j)
#SBATCH -e logs/jobs/%j.err                            # File to which STDERR will be written, including job ID (%j)
#SBATCH --mail-type=ALL                      # ALL email notification type
#SBATCH --mail-user=<james_warner@hms.harvard.edu>          # Email to which notifications will be sent


cp -r input/split_inputs input/repeat_inputs

for PART in output/*; do

        LALA=$(basename $PART)

        for NAME in ${PART}/*done.txt; do

                FOLD=$(basename $NAME .done.txt)

                sed -i "/${FOLD}/d" input/repeat_inputs/${LALA}.csv

        done

done