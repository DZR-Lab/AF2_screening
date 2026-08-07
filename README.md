# One-by-all Alphafold2 screen pipeline

## description

- lala

## requirements

- lala

## instructions

**0. Set up to run analysis.**
If this is your first time running an Alphafold screen using this repository, you will have to set up a conda environment to run the [analysis](https://github.com/walterlab-HMS/AF2multimer-analysis.git). Instructions to do this can be found in `set_up/set_up_conda_env.txt`.

**1. Clone repository.**
```bash
# request an interactive session on O2
srun --account=rudner --pty -p interactive --mem 1G -t 0-00:30 /bin/bash

# once your session has started and you have your cursor back
git clone https://github.com/jamwarner/AF2_screening.git
```

**2. Rename repository.**
```bash
mv AF2_screening <YOUR_NAME_HERE>
```

**3. Edit `input/query.fa` to be your query seqeunce.**
```
>ID
SEQUENCE
```

**4. Upload proteome to `proteome/` directory.**
Edit `scripts/one-by-all_generator.py` to correct file name.

**5. Generate one-by-all file.**
```bash
python scripts/one-by-all_generator.py
```

**6. Split one-by-all file into parts.**
```bash
python scripts/multiple_alphafold_files_roundrobin.py
```

**7. Edit `scripts/proteome_screen_array.sh` header with your email.**

**8. Submit job.**
```bash
sbatch scripts/proteome_screen_array.sh
```

**9. Restart jobs.**
If jobs run out of time or memory, create input files to restart analysis where it left off

```bash
sbatch scripts/make_repeat_inputs.sh
```

Note: This can be done multiple times if your folds run out of time or memory more than once. The initial input files can always be found in `input/split_inputs/` and the inputs for the restart are found in `input/repeat_inputs/` and get overwritten by this script.

```bash
# submit restart jobs -- don't forget to edit the SLURM header to add your email
sbatch scripts/proteome_screen_array_repeat.sh
```

**10. Once jobs are complete, perform analysis.**
You can check completion by running:
```bash
# tells you how many folds are in each 'part'
for name in input/split_inputs/*; do echo $name; tail -n +2 $name | wc -l; done

# tells you how many folds are complete for each 'part'
for name in output/*; do echo $name; ls -1 $name/*done.txt | wc -l; done

# when the numbers are the same, your folds are all complete
```

```bash
sbatch scripts/analysis.sh
```

Note: This script can be run while your folds are running. It will analyze any completed folds found in your `output/` directory.

