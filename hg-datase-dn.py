import datasets
import os
data = datasets.load_dataset("Matthijs/cmu-arctic-xvectors", split="validation")
os.makedirs("files", exist_ok=True)
data.save_to_disk("files")
