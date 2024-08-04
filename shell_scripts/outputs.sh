#!/bin/bash

file_name="tf-outputs"

# check if file already exists, if so, delete it
if [ -e "${file_name}.env" ]; then
    rm -f "${file_name}.env"
    echo "A file already existed, but not anymore HAHA"
fi

# creates a new file in a project root dir
touch "${file_name}.env" || { echo "A file already exists"; exit 1; }

# changes dir to root/terraform
cd terraform || { echo "Failed to change dirrctory to terraform"; exit 1; }

# runs a command and saves its output to a file
terraform output > "../${file_name}.env"
echo "Outputs were saved to ${file_name}.env"