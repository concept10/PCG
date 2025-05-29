#!/bin/bash

# PowerShell Development Environment Setup Script
# This script configures the development environment for PowerShell scripting

set -e

echo "🚀 Setting up PowerShell development environment..."

# Get PowerShell version from environment variable (default to 7.x)
POWERSHELL_VERSION=${POWERSHELL_VERSION:-"7.x"}

echo "📋 PowerShell version requested: $POWERSHELL_VERSION"

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update

# Install common development tools
echo "🔧 Installing development tools..."
sudo apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    jq \
    tree \
    nano \
    vim

# Install PowerShell based on version
if [[ "$POWERSHELL_VERSION" == "5.x" ]]; then
    echo "🐚 Setting up PowerShell 5.x compatibility environment..."
    echo "⚠️  Note: PowerShell 5.x is Windows-specific. Installing PowerShell 7.x for cross-platform compatibility."
    echo "⚠️  Use Windows PowerShell ISE or VS Code with PowerShell extension for 5.x development."
    POWERSHELL_VERSION="7.x"
fi

if [[ "$POWERSHELL_VERSION" == "7.x" || "$POWERSHELL_VERSION" == "latest" ]]; then
    echo "🐚 Installing PowerShell 7.x..."

    # PowerShell 7.x is already installed via the devcontainer feature
    # Just verify it's working
    if command -v pwsh &> /dev/null; then
        echo "✅ PowerShell 7.x is installed"
        pwsh -c '$PSVersionTable'
    else
        echo "❌ PowerShell installation failed"
        exit 1
    fi
fi

# Install PowerShell modules commonly used in development
echo "📚 Installing common PowerShell modules..."
pwsh -c "
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name Pester -Force -Scope AllUsers
    Install-Module -Name PSScriptAnalyzer -Force -Scope AllUsers
    Install-Module -Name platyPS -Force -Scope AllUsers
    Install-Module -Name PowerShellGet -Force -Scope AllUsers -AllowClobber
"

# Create PowerShell profile directory
echo "📁 Creating PowerShell profile directory..."
pwsh -c "
    if (!(Test-Path -Path \$PROFILE)) {
        New-Item -ItemType File -Path \$PROFILE -Force
        Write-Host 'PowerShell profile created at:' \$PROFILE
    }
"

# Set up git configuration (if not already configured)
echo "🔧 Configuring git..."
if ! git config --global user.name > /dev/null 2>&1; then
    echo "ℹ️  Git user.name not configured. You may want to set it with: git config --global user.name 'Your Name'"
fi

if ! git config --global user.email > /dev/null 2>&1; then
    echo "ℹ️  Git user.email not configured. You may want to set it with: git config --global user.email 'your.email@example.com'"
fi

# Create workspace directories
echo "📁 Setting up workspace structure..."
mkdir -p /workspace/{scripts,modules,tests,docs,tools}

# Create sample PowerShell script for testing
cat > /workspace/scripts/sample.ps1 << 'EOF'
#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Sample PowerShell script for testing the development environment.

.DESCRIPTION
    This script demonstrates basic PowerShell functionality and can be used
    to verify that the development environment is working correctly.

.EXAMPLE
    ./sample.ps1
    Runs the sample script with default parameters.

.EXAMPLE
    ./sample.ps1 -Name "World" -Verbose
    Runs the script with custom name parameter and verbose output.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$Name = "PowerShell Developer"
)

Write-Verbose "Starting sample script execution..."

Write-Host "Hello, $Name!" -ForegroundColor Green
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
Write-Host "Platform: $($PSVersionTable.Platform)" -ForegroundColor Yellow

# Test some basic PowerShell functionality
$currentDate = Get-Date
Write-Host "Current Date: $currentDate" -ForegroundColor Magenta

# Display environment information
Write-Host "`nEnvironment Information:" -ForegroundColor Blue
Write-Host "- Working Directory: $(Get-Location)" -ForegroundColor Gray
Write-Host "- PowerShell Edition: $($PSVersionTable.PSEdition)" -ForegroundColor Gray
Write-Host "- OS: $($PSVersionTable.OS)" -ForegroundColor Gray

Write-Verbose "Sample script execution completed."
EOF

# Make the sample script executable
chmod +x /workspace/scripts/sample.ps1

# Create a simple Pester test
cat > /workspace/tests/sample.tests.ps1 << 'EOF'
Describe "Sample PowerShell Tests" {
    Context "Basic PowerShell Functionality" {
        It "Should have PowerShell available" {
            $PSVersionTable.PSVersion | Should -Not -BeNullOrEmpty
        }

        It "Should be able to create variables" {
            $testVar = "Hello, World!"
            $testVar | Should -Be "Hello, World!"
        }

        It "Should be able to use cmdlets" {
            Get-Date | Should -Not -BeNullOrEmpty
        }
    }

    Context "Sample Script Tests" {
        It "Should exist" {
            Test-Path "/workspace/scripts/sample.ps1" | Should -Be $true
        }

        It "Should be executable" {
            # This test verifies the script can be invoked without syntax errors
            { & "/workspace/scripts/sample.ps1" -Name "Test" } | Should -Not -Throw
        }
    }
}
EOF

echo "✅ PowerShell development environment setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Open VS Code and install the PowerShell extension if not already installed"
echo "2. Test the environment by running: pwsh /workspace/scripts/sample.ps1"
echo "3. Run tests with: pwsh -c 'Invoke-Pester /workspace/tests/'"
echo "4. Start developing your PowerShell scripts in the /workspace directory"
echo ""
echo "📚 Installed PowerShell modules:"
pwsh -c "Get-InstalledModule | Select-Object Name, Version | Format-Table"
