#!/bin/bash

# Replace with your GitHub username and repository name
USERNAME="mcreddi1"
REPO="devopspractice"

# Replace with your GitHub personal access token
TOKEN= $1 #please use your github PAT(personal access token)

# GitHub API endpoint to list repository collaborators
URL="https://api.github.com/repos/${USERNAME}/${REPO}/collaborators"

# Make GET request to GitHub API using curl, passing the token for authentication
response=$(curl -s -H "Authorization: token ${TOKEN}" "${URL}")

# Check if request was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch collaborators."
    exit 1
fi

# Parse JSON response using jq to extract collaborator usernames
collaborators=$(echo "${response}" | jq -r '.[].login')

# Print out the list of collaborators
echo "Collaborators for ${USERNAME}/${REPO}:"
echo "${collaborators}"
