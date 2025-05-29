FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG POWERSHELL_VERSION=7.x

# Install dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl \
    wget \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    gnupg \
    lsb-release

# Install PowerShell based on version argument
RUN if [ "$POWERSHELL_VERSION" = "7.x" ] || [ "$POWERSHELL_VERSION" = "latest" ]; then \
    # Install PowerShell 7.x
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -rs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    apt-get install -y powershell; \
    fi

# Install common PowerShell modules
RUN pwsh -c " \
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module -Name Pester -Force -Scope AllUsers; \
    Install-Module -Name PSScriptAnalyzer -Force -Scope AllUsers; \
    Install-Module -Name platyPS -Force -Scope AllUsers; \
    Install-Module -Name PowerShellGet -Force -Scope AllUsers -AllowClobber; \
    "

# Create PowerShell profile
RUN pwsh -c "New-Item -ItemType File -Path \$PROFILE -Force"

# Set up workspace directories
RUN mkdir -p /workspace/{scripts,modules,tests,docs,tools}

# Set permissions
RUN chown -R vscode:vscode /workspace
