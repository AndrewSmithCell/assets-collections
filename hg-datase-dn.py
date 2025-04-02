import datasets
import os
data = datasets.load_dataset("open-r1/codeforces-cots", split="validation")
os.makedirs("files", exist_ok=True)
data.save_to_disk("files")
