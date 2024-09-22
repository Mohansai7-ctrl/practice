#!/bin/bash

search_term="error"
log_file="application.log"
if grep -q "$search_term" "$log_file"; then
    echo "Found '$search_term' in $log_file"
else
    echo "No '$search_term' found in $log_file"
fi