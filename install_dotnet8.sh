#!/bin/bash
###################################################################
#Script Name:Dotnet8 Installer
#Description:Script für die Installation von Dotnet 8 auf Raspian
#Copyright: TiBo aka. MrGreenscreen
###################################################################

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y libc6 libgcc1 libgssapi-krb5-2 libssl1.1 libstdc++6 zlib1g

# Download the .NET SDK 8.0 for ARM64
echo "Downloading .NET 8 SDK for ARM64..."
wget https://download.visualstudio.microsoft.com/download/pr/5ac82fcb-c260-4c46-b62f-8cde2ddfc625/feb12fc704a476ea2227c57c81d18cdf/dotnet-sdk-8.0.404-linux-arm64.tar.gz -O dotnet-sdk-8.0.404-linux-arm64.tar.gz

# Create installation directory
echo "Creating installation directory..."
mkdir -p $HOME/dotnet8

# Extract .NET SDK
echo "Extracting .NET SDK..."
tar zxf dotnet-sdk-8.0.404-linux-arm64.tar.gz -C $HOME/dotnet

# Clean up the downloaded archive
rm dotnet-sdk-8.0.404-linux-arm64.tar.gz

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
