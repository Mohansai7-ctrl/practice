input_file="/D/devops/daws-81s/repo/practice/input.txt"

grep pysli $input_file | awk -F " " '{print $1F "==" $2F}'