import json
import os

import requests
from huggingface_hub import snapshot_download

if __name__ == '__main__':

    home_dir = 'files'
    os.makedirs(home_dir)
    layoutreader_dataset_dir = snapshot_download('Matthijs/cmu-arctic-xvectors', repo_type="dataset", local_dir=home_dir, local_dir_use_symlinks=False,)
    print(f'dataset_dir is: {layoutreader_dataset_dir}')
