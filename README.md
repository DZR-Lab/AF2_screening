# One-by-all Alphafold2 screen pipeline

## description

A pipeline for performing and analyzing one-by-all Alphafold2 screens.

## requirements

- Designed to be run on O2, the high-performance cluster at HMS
- Uses the slurm job scheduler to submit job arrays
	- The slurm directives provided with these scripts presume that you are an O2 user with permissions to submit jobs to the Rudner Lab's GPUs. You will need to edit the `#SBATCH` headers appropriately if this is not the case.
- Query protein sequence in FASTA format
- Proteome to be screened against
	- I recommend downloading from [Uniprot](https://www.uniprot.org/proteomes?query=*). The file should be in `.tsv` format and contain at least the following columns: "Entry" "Sequence" "Length"

## instructions

**0. Set up to run analysis.**

If this is your first time running an Alphafold screen using this repository, you will have to set up a conda environment to run the [analysis](https://github.com/walterlab-HMS/AF2multimer-analysis.git). Instructions to do this can be found in `set_up/set_up_conda_env.txt` once you have cloned this repository. You only need to do this once -- the environment will be installed in your home directory on O2.

**1. Clone repository.**

This should not be done in your `home/` directory, as the screen output will require more storage than O2 users are alloted. Use either your scratch directory  (`/n/scratch/users/...`) or the Rudner lab directory (`/n/data1/hms/microbiology/rudner/lab/...`).

```bash
# request an interactive session on O2
srun --account=rudner --pty -p interactive --mem 1G -t 0-00:30 /bin/bash

# once your session has started and you have your cursor back
git clone https://github.com/DZR-Lab/AF2_screening.git
```

**2. Rename repository.**

```bash
mv AF2_screening <YOUR_SCREEN_NAME_HERE>
```

Navigate into the new directory.

```bash
cd <YOUR_SCREEN_NAME_HERE>
```

All scripts should be run from this directory (the root of this repository).

**3. Edit `input/query.fa` to be your query sequence.**

File should be in FASTA format. For example:

```
>UNIPROT_ID
SEQUENCE
```

**4. Upload proteome to `proteome/` directory.**

Edit `scripts/one-by-all_generator.py` line 25 to correct proteome file name.

**5. Generate one-by-all file.**

```bash
python scripts/one-by-all_generator.py
```

**6. Split one-by-all file into parts.**

```bash
python scripts/multiple_alphafold_files_roundrobin.py
```

**7. Edit `scripts/proteome_screen_array.sh` header with your email.**

O2 will now email you when your job begins and when it ends. This is helpful; runs frequently take days to complete.


**8. Submit job.**

```bash
sbatch scripts/proteome_screen_array.sh
```

**9. Restart jobs.**

Jobs frequently run out of time or memory, especially if you are screening against an entire proteome. If this happens, this script will create input files to restart the screen where it left off.

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

To analyze folds, run:

```bash
sbatch scripts/analysis.sh
```

Note: This script can be run while your folds are running. It will analyze any completed folds found in your `output/` directory.

