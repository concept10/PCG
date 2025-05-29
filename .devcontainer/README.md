# PowerShell Development Container

This devcontainer provides a complete development environment for PowerShell scripting that works across Windows 10, 11, and Server editions.

## Features

- **PowerShell 7.x**: Latest cross-platform PowerShell
- **VS Code Extensions**: Pre-configured with PowerShell and related extensions
- **Development Tools**: Pester, PSScriptAnalyzer, platyPS, and more
- **Cross-Platform**: Works on Windows, macOS, and Linux hosts
- **Configurable**: Easy switching between PowerShell versions

## Quick Start

1. **Prerequisites**:
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Install [VS Code](https://code.visualstudio.com/)
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in Container**:
   - Open this folder in VS Code
   - When prompted, click "Reopen in Container"
   - Or use Command Palette: `Dev Containers: Reopen in Container`

3. **Test the Environment**:

   ```powershell
   # Run the sample script
   pwsh /workspace/scripts/sample.ps1

   # Run tests
   pwsh -c 'Invoke-Pester /workspace/tests/'
   ```

## Configuration

### PowerShell Version

Edit `.devcontainer/.env` to configure the PowerShell version:

```env
# Options: "5.x", "7.x", "latest"
POWERSHELL_VERSION=7.x
```

**Note**: PowerShell 5.x is Windows-specific. When developing in the container, PowerShell 7.x provides the best cross-platform compatibility. For PowerShell 5.x development, use Windows PowerShell ISE or VS Code on Windows.

### Custom Extensions

Add extensions in `.devcontainer/devcontainer.json`:

```json
"extensions": [
  "ms-vscode.powershell",
  "your.extension.id"
]
```

## Folder Structure

```text
/workspace/
├── scripts/     # PowerShell scripts
├── modules/     # PowerShell modules
├── tests/       # Pester tests
├── docs/        # Documentation
└── tools/       # Development tools
```

## Pre-installed Modules

- **Pester**: PowerShell testing framework
- **PSScriptAnalyzer**: PowerShell script analyzer
- **platyPS**: Documentation generation
- **PowerShellGet**: Module management

## Development Workflow

1. **Write Scripts**: Create PowerShell scripts in `/workspace/scripts/`
2. **Test Code**: Write Pester tests in `/workspace/tests/`
3. **Analyze Code**: Use PSScriptAnalyzer for best practices
4. **Debug**: Use VS Code's integrated debugging features

### Example Commands

```powershell
# Analyze a script
Invoke-ScriptAnalyzer /workspace/scripts/sample.ps1

# Run all tests
Invoke-Pester /workspace/tests/

# Run specific test
Invoke-Pester /workspace/tests/sample.tests.ps1

# Get PowerShell version info
$PSVersionTable
```

## Windows-Specific Development

For PowerShell 5.x and Windows-specific features:

1. **Local Development**: Use VS Code on Windows with PowerShell extension
2. **Testing**: Test scripts on actual Windows environments
3. **Modules**: Some Windows modules may not work in the Linux container

## Troubleshooting

### Container Won't Start

- Ensure Docker Desktop is running
- Check Docker Desktop settings for file sharing permissions

### PowerShell Issues

- Verify PowerShell installation: `pwsh --version`
- Check module installation: `Get-InstalledModule`

### Permission Issues

- The container runs as the `vscode` user
- Files created in the container will be owned by this user

## Contributing

1. Fork the repository
2. Make changes in a feature branch
3. Test in the devcontainer
4. Submit a pull request

## Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [Pester Documentation](https://pester.dev/)
- [VS Code PowerShell Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
- [Dev Containers Documentation](https://code.visualstudio.com/docs/remote/containers)
