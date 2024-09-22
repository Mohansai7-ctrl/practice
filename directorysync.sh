#!/bin/bash

# Source and destination directories
source_dir=$1
destination_dir=$2

usage(){

    echo "usage: sh scriptname <sourcedir> <destinationdir>"
}

if [ $# -lt 2 ]
then
    usage
    exit 1
fi

# Check if both directories exist
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' not found."
    exit 1
    else
    echo "$source_dir exists...."
fi

if [ ! -d "$destination_dir" ]; then
    echo "Error: Destination directory '$destination_dir' not found."
    exit 1
    else
    echo "$destination_dir exists..."
fi

echo "listing files in source directory"
ls -l $source_dir/*

# Synchronize directories using rsync
#rsync_options="-av --update --ignore-existing --progress --exclude='.git/'"  # Adjust options as needed
rsync -av --update --ignore-existing --progress --exclude='.git/' "$source_dir/" "$destination_dir/"

#sync "$rsync" "$source_dir/" "$destination_dir/"

# Check rsync exit status
if [ $? -ne 0 ]; then
    echo "Error: Failed to synchronize directories."
    exit 1
else
    echo "Directories synchronized successfully."
fi

echo "removing the files from the source directory after the sync happened"
removefiles=$(find "$source_dir" -type f -exec rm -f {} \;)

if [ $? -ne 0 ]; then
    echo "removing files from source directory failed."
else
    echo "successfully removing files from source directory."
fi


echo "listing files in destination directory"
ls -l $destination_dir/*

# Optional: Check for any files that couldn't be copied due to errors
# This can include locked files or permission issues
failed_files="$(find "$source_dir" -type f -newermt "$(date -R -d '-1 minute')" -exec cp -n {} "$destination_dir" \; 2>&1 | grep -E 'cannot (open|stat|create)' | awk -F ': ' '{print $2}')"

if [ -n "$failed_files" ]; then
    echo "Warning: Some files could not be copied due to errors:"
    echo "$failed_files"
fi
