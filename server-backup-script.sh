#!/bin/bash

backup_dir="/backup"
source_dir="/var/www/html"
# Create a backup directory
mkdir -p "$backup_dir"
# Perform the backup
rsync -av "$source_dir" "$backup_dir"