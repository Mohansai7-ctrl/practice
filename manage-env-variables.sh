#!/bin/bash

# Define environment variables
export DATABASE_URL="mysql://username:password@localhost/database"
# Use environment variables in your scripts
echo "Database URL: $DATABASE_URL"