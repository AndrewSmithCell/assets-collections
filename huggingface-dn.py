import json
import os

import requests
from huggingface_hub import snapshot_download

if __name__ == '__main__':

    home_dir = 'files'
    os.makedirs(home_dir)
    layoutreader_model_dir = snapshot_download('hantian/layoutreader', local_dir=home_dir, local_dir_use_symlinks=False,)
    print(f'model_dir is: {layoutreader_model_dir}')
