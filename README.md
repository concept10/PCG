# PCG

Personal Computer Geek

## Development Environment

This project includes a complete PowerShell development environment using VS Code Dev Containers. The environment supports both PowerShell 5.x and 7.x development and works across Windows 10, 11, and Server editions.

### Quick Start with Dev Container

1. **Prerequisites**:
   - [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - [VS Code](https://code.visualstudio.com/)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in Container**:
   - Open this folder in VS Code
   - When prompted, click "Reopen in Container"
   - Or use Command Palette: `Dev Containers: Reopen in Container`

3. **Start Developing**:
   - PowerShell scripts in `scripts/` folder
   - Tests in `tests/` folder using Pester
   - Use built-in debugging and analysis tools

See [.devcontainer/README.md](.devcontainer/README.md) for detailed documentation.

### Features

- **Cross-Platform**: Works on Windows, macOS, and Linux hosts
- **PowerShell 7.x**: Latest cross-platform PowerShell
- **Development Tools**: Pester, PSScriptAnalyzer, platyPS
- **VS Code Integration**: Debugging, IntelliSense, formatting
- **Configurable**: Easy switching between PowerShell versions
