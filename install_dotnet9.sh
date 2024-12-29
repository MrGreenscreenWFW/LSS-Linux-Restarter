#!/bin/bash
###################################################################
#Script Name: Dotnet9 Installer
#Description: Script für die Installation von Dotnet 9 auf Raspian
#Copyright: TiBo aka. MrGreenscreen
###################################################################

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y libc6 libgcc1 libgssapi-krb5-2 libssl1.1 libstdc++6 zlib1g

# Download the .NET SDK 9.0 for ARM64
echo "Downloading .NET 9 SDK for ARM64..."
wget https://download.visualstudio.microsoft.com/download/pr/93a7156d-01ef-40a1-b6e9-bbe7602f7e8b/3c93e90c63b494972c44f073e15bfc26/dotnet-sdk-9.0.101-linux-arm64.tar.gz -O dotnet-sdk-9.0.101-linux-arm64.tar.gz

# Create installation directory
echo "Creating installation directory..."
mkdir -p $HOME/dotnet

# Extract .NET SDK
echo "Extracting .NET SDK..."
tar zxf dotnet-sdk-9.0.101-linux-arm64.tar.gz -C $HOME/dotnet

# Clean up the downloaded archive
rm dotnet-sdk-9.0.101-linux-arm64.tar.gz

# Add DOTNET_ROOT and update PATH in .bashrc
echo "Configuring environment variables..."
if ! grep -q 'DOTNET_ROOT' ~/.bashrc; then
    echo 'export DOTNET_ROOT=$HOME/dotnet' >> ~/.bashrc
    echo 'export PATH=$PATH:$HOME/dotnet' >> ~/.bashrc
fi

# Reload .bashrc to apply changes
echo "Applying environment changes..."
source ~/.bashrc

# Verify installation
echo "Verifying .NET installation..."
dotnet_version=$(dotnet --version)
if [ $? -eq 0 ]; then
    echo ".NET SDK $dotnet_version installed successfully!"
else
    echo "Installation failed. Please check the output for errors."
fi
