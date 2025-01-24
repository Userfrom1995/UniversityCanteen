#!/bin/bash

# Exit the script if any command fails
set -e

# Function to handle errors and provide a custom message
error_exit() {
  echo "[ERROR] $1"
  exit 1
}

# Update the system package list
echo "Updating package list..."
sudo apt-get update || error_exit "Failed to update package list."

# Add the .NET PPA (for the latest .NET version, make sure .NET 9.0 is available)
echo "Adding the .NET PPA..."
sudo add-apt-repository ppa:dotnet/backports -y || error_exit "Failed to add .NET PPA."

# Update the package list again after adding the repository
echo "Updating package list again after adding PPA..."
sudo apt-get update || error_exit "Failed to update package list after adding PPA."

# Install .NET SDK, Runtime, and ASP.NET Core Runtime
echo "Installing .NET SDK, ASP.NET Core Runtime, and .NET Runtime..."
sudo apt-get install -y dotnet-sdk-9.0 || error_exit "Failed to install .NET SDK."
sudo apt-get install -y aspnetcore-runtime-9.0 || error_exit "Failed to install ASP.NET Core Runtime."
sudo apt-get install -y dotnet-runtime-9.0 || error_exit "Failed to install .NET Runtime."

# Navigate to the JamiaCanteen project directory, restore dependencies and build the project
echo "Navigating to JamiaCanteen directory..."
cd JamiaCanteen || error_exit "Failed to navigate to JamiaCanteen directory."

echo "Restoring dependencies for JamiaCanteen project..."
dotnet restore || error_exit "Failed to restore dependencies for JamiaCanteen."

echo "Building JamiaCanteen project..."
dotnet build || error_exit "Failed to build JamiaCanteen project."

# Navigate to the DBMS-Project directory and run the project
echo "Navigating to DBMS-Project directory..."
cd DBMS-Project || error_exit "Failed to navigate to DBMS-Project directory."

echo "Running DBMS-Project..."
dotnet run || error_exit "Failed to run DBMS-Project."

echo "Setup completed successfully!"
