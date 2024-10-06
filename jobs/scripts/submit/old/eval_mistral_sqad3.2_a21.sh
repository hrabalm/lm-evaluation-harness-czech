#!/usr/bin/bash
#SBATCH --job-name eval
#SBATCH --account OPEN-28-55
#SBATCH --partition qgpu
#SBATCH --time 12:00:00
#SBATCH --gpus-per-node 8
#SBATCH --nodes 1

TASK="benczechmark_cs_sqad32"
OUTPUT_PATH="results/eval_mistral_sqad_3.2"
JOBSCRIPT="./jobs/scripts/eval_mistral_accelerate.sh"

# export PYTHON
export PYTHON=/mnt/data/ifajcik/micromamba/envs/envs/lmharness/bin/python
export TOKENIZERS_PARALLELISM=true
export HF_HOME="/mnt/nvme/ifajcik/huggingface_cache"
export CACHE_NAME="mistral_sqad_10s_accelerate_a21"

# cd to the right directory
cd /mnt/data/ifajcik/lm_harness || exit
export PYTHONPATH=$(pwd)
chmod +rx $JOBSCRIPT || exit

set -x # enables a mode of the shell where all executed commands are printed to the terminal
$JOBSCRIPT "$TASK" "$OUTPUT_PATH"  | tee -a "eval_mistral_sqad32.log"
set +x
