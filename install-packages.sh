#!/bin/bash

# Define a function to install packages
install_packages() {
    local package_manager=""
    
    # Check which package manager is available
    if [ -x "$(command -v apt-get)" ]; then
        package_manager="apt-get"
    elif [ -x "$(command -v yum)" ]; then
        package_manager="yum"
    else
        echo "Error: No supported package manager found."
        exit 1
    fi
    echo "Updating package lists..."
    sudo $package_manager update -y
    echo "Installing packages..."
    sudo $package_manager install -y package1 package2 package3
}
# Call the function to install packages
install_packages