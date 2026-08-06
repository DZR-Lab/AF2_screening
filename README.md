instructions

1. Clone repository
srun --account=rudner --pty -p interactive --mem 1G -t 0-00:30 /bin/bash

git clone https://github.com/jamwarner/AF2_screening.git

2. Rename repository
mv AF2_screening <YOUR_NAME_HERE>

3. Edit input/query.fa to be your query seqeunce.
>ID
SEQUENCE

4. Upload proteome to proteome directory.
Edit scripts/one-by-all_generator.py to correct file name.

5. Generate one-by-all file.
python scripts/one-by-all_generator.py

6. Split one-by-all file into parts.
python scripts/multiple_alphafold_files_roundrobin.py

7. Edit scripts/proteome_screen_array.sh header with your email.

8. Submit job.
sbatch scripts/proteome_screen_array.sh