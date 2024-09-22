#!/bin/bash

#need to check some errors are there

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <string_to_replace>"
    exit 1
fi

# Assign command line arguments to variables
directory="$1"
string_to_replace="$2"

# Verify if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Find all text files in the specified directory
find "$directory" -type f -name "*.txt" | while read -r file; do
    # Check if the string to replace exists in the file
    if grep -q "$string_to_replace" "$file"; then
        # Replace the string using sed
        sed -i "s/$string_to_replace/new_string/g" "$file"
        echo "Replaced '$string_to_replace' in '$file'"
    fi
done

echo "String replacement complete."
